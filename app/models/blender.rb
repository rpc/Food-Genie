class Blender

  include ActiveModel
  include ActiveModel::Validations
  
  STOP_WORDS = [" de "," com "]
  MEASURE_WORDS = ["colheres","pacote","quarts","teaspoon","cups","tablespoons"]
  PLAUSIBLE_MEASURE_SIZE = 3
  
  attr_accessor :blending_text, :blending_ingredients
  attr_accessor :difficulty, :time, :category, :many_ppl, :title
  
  validates_presence_of :difficulty, :message => "Please choose the difficulty"
  validates_presence_of :time, :message => "Choose the cooking time"
  validates_presence_of :category, :message => "Choose the food category"
  validates_presence_of :many_ppl, :message => "Choose how many ppl"
  validates_presence_of :title, :message => "Choose a title"
  
  validates_numericality_of :many_ppl, :time
  
  validates_presence_of :blending_ingredients, :message => "Cant blend withou ingredients"
  validates_presence_of :blending_text, :message => "You must provide a text"
  
  def initialize(blending_params)
    self.blending_text = blending_params[:blending_text]
    self.blending_ingredients = blending_params[:blending_ingredients]    
    self.difficulty = blending_params[:difficulty]    
    self.time = blending_params[:time]    
    self.category = blending_params[:category]    
    self.many_ppl = blending_params[:many_ppl]
    self.title = blending_params[:recipe_title]
  end
  
  def blend
    #Rails.logger.debug "== Blender::blend"
    ok_count = 0
    ingredient_list = []
    
    recipe = Recipe.new(:many_ppl => self.many_ppl,
                           :title => self.title, 
                           :difficulty => self.difficulty, 
                           :time => self.time, 
                           :category_id => self.category, 
                           :text => self.blending_text, 
                           :approved => false)
    
    
    unless self.blending_ingredients.blank?
      blending_ingredients.split("\n").each do |ingredient|
        if parse_ingredients(ingredient, recipe) 
          ok_count += 1 
        end
        Rails.logger.debug "\n"
      end
    end
    
    recipe.save! # BANG
    Rails.logger.debug "= Result: #{ok_count}/#{blending_ingredients.split("\n").count}"    
    return recipe
  end
  
  def parse_ingredients ingredient_line, recipe    
  
    Rails.logger.debug "== Blender::parse_ingredients"
   
    # Removes MINUS "-"
    ingredient_line.gsub!("-","")    
    # Removes Complementary Words
    ingredient_line.gsub!(/\b(#{STOP_WORDS.join('|')})\b/mi, ' ')
    # Parses line
    measure, quantity = get_measure_and_quantity ingredient_line
   
    # TODO: Tudo no mesmo GSUB
    ingredient_line_as_array = ingredient_line.split(" ")
    ingredient_line_as_array.delete(measure)
    ingredient_line_as_array.delete(quantity)
    
    # Removes all unecessary spaces
    food_item_name = ingredient_line_as_array.join(" ")
    
    #Rails.logger.debug "* Parsed Ingredient: [Q]:#{quantity} [M]:#{measure} [N]:#{food_item_name}"
    Rails.logger.debug "* Parsed Ingredient: Quant:(#{quantity}) Meas:(#{measure}) Name:(#{food_item_name})"
    
    add_ingredient_to_recipe quantity, measure, food_item_name, recipe 
    return !measure.nil? && !quantity.nil?
  end
  
  def add_ingredient_to_recipe quantity, measure, food_item_name, recipe
    food_item = FoodItem.new(:name => food_item_name, :price => nil)
    ingredient = Ingredient.new(:food_item => food_item, :quantity => quantity, :measure => measure, :recipe_id => recipe.id)
    recipe.ingredients << ingredient
  end
  
  def get_measure_and_quantity ingredient_line
  
    Rails.logger.debug "** Blender::get_measure_and_quantity"
    Rails.logger.debug "* ingredient_line: #{ingredient_line}"
    
    quantity = nil
    measure = nil   

    if has_any_number?(ingredient_line)  
      split_string = ingredient_line.split(" ") # 4 OR 4KG
      
      # metodo para ver se tem algum numero      
      first_token = split_string.first
      second_token = split_string.second
      
      # Could be: 4 KG; 4KG; 1/4 KG; 2 1/5 KG      
      if( is_digit?(first_token) && !has_a_slash?(first_token) ) # 4 KG or 2 1/5 Kg
        if( has_a_slash?(second_token) ) # 2 1/5 KG
          quantity = first_token.concat(" "+second_token)
          third_token = split_string.third
          measure = third_token unless (third_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(third_token))
        else  # its 4 KG
          quantity = first_token
          measure = second_token unless (second_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(second_token))
        end      
      else # Its stuck together or has slash (4Kg or 1/4 KG)
        if(has_a_slash?(first_token) && !is_digit(second_token) ) # its 1/4 KG
          quantity = first_token
          measure = second_token unless (second_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(second_token))
        else # Its stuck , 4Kg
          quantity = first_token.gsub(/[^0-9]/, '')
          temp_measure = first_token.gsub(/[^A-Za-z]/, '')
          measure = temp_measure unless (first_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(temp_measure))
        end     
      end 
    
    end
    return measure, quantity
  end
  
  #private 
  def is_digit? str
    begin Float(str) ; true end rescue false  
  end
  
  def has_any_number? str
    !(str =~ /\d/).nil?
  end
  
  def has_a_slash? str
    str.include?("/")
  end 

end

