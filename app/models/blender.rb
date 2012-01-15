class Blender < ActiveRecord::Base
  
  STOP_WORDS = [" de "," com "]
  MEASURE_WORDS = ["colheres","pacote","quarts","teaspoon","cups","tablespoons"]
  PLAUSIBLE_MEASURE_SIZE = 4
  
  validates_presence_of :difficulty, :message => "Please choose the difficulty"
  validates_presence_of :time, :message => "Choose the cooking time"
  validates_presence_of :category, :message => "Choose the food category"
  validates_presence_of :many_ppl, :message => "Choose how many ppl"
  validates_presence_of :title, :message => "Choose a title"
  
  validates_numericality_of :many_ppl, :time
  
  validates_presence_of :blending_ingredients, :message => "Cant blend withou ingredients"
  validates_presence_of :blending_text, :message => "You must provide a text"
  
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
    measure, quantity, ingredient = get_measure_quantity_and_ingredient ingredient_line
           
    Rails.logger.debug "* Parsed Ingredient: Quant:(#{quantity}) Meas:(#{measure}) Name:(#{ingredient})"
    
    add_ingredient_to_recipe quantity, measure, ingredient, recipe 
    return !measure.nil? && !quantity.nil?
  end
  
  def add_ingredient_to_recipe quantity, measure, food_item_name, recipe
    food_item = FoodItem.new(:name => food_item_name, :price => nil)
    ingredient = Ingredient.new(:food_item => food_item, :quantity => quantity, :measure => measure, :recipe_id => recipe.id)
    recipe.ingredients << ingredient
  end
  
  def get_measure_quantity_and_ingredient ingredient_line
  
    Rails.logger.debug "** Blender::get_measure_and_quantity"
    Rails.logger.debug "* ingredient_line: #{ingredient_line}"
    
    quantity = nil
    measure = nil   
    ingredient = []
    split_string = ingredient_line.split(" ")

    if has_any_number?(ingredient_line) and  split_string.size > 1      
      # metodo para ver se tem algum numero      
      first_token = split_string.shift
      second_token = split_string.shift
      
      # Could be: 4 KG; 4KG; 1/4 KG; 2 1/5 KG      
      if( is_digit?(first_token) && !has_a_slash?(first_token) ) # 4 KG or 2 1/5 Kg
        if( has_a_slash?(second_token) ) # 2 1/5 KG
          quantity = first_token.concat(" "+second_token)
          third_token = split_string.shift
          measure = validate_measure third_token, ingredient
        else  # its 4 KG
          quantity = first_token
          measure = validate_measure second_token, ingredient         
        end      
      else # Its stuck together or has slash (4Kg or 1/4 KG)
        if(has_a_slash?(first_token) && !is_digit(second_token) ) # its 1/4 KG
          quantity = first_token
          measure = validate_measure second_token, ingredient          
        else # Its stuck , 4Kg
          quantity = first_token.gsub(/[^0-9]/, '')
          temp_measure = first_token.gsub(/[^A-Za-z]/, '')
          measure = validate_measure temp_measure, ingredient          
        end      
      end 
    end
    
    ingredient << split_string
    return measure, quantity, ingredient.join(" ")
  end
  
  #private  
  def validate_measure measure_token, ingredient_list
    measure = nil
    if (MEASURE_WORDS.include?(measure_token)) || (measure_token.size < PLAUSIBLE_MEASURE_SIZE) 
      measure = measure_token
    else
      ingredient_list << measure_token
    end
    return measure      
  end
  
  def is_digit? str
    begin Float(str) ; true end rescue false  
  end
  
  def has_any_number? str
    !str.nil? and !(str =~ /\d/).nil?
  end
  
  def has_a_slash? str
    !str.nil? and str.include?("/")
  end 

end

