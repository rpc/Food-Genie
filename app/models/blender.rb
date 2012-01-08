class Blender

  include ActiveModel
  include ActiveModel::Validations
  
  STOP_WORDS = [" de "," com "]
  MEASURE_WORDS = ["colheres","pacote","quarts","teaspoon","cups","tablespoons"]
  PLAUSIBLE_MEASURE_SIZE = 3
  
  attr_accessor :blending_text, :blending_ingredients
  validates_presence_of :blending_ingredients, :message => "Cant blend withou ingredients"
  validates_presence_of :blending_text, :message => "You must provide a text"
  
  def initialize(blending_params)
    self.blending_text = blending_params[:blending_text]
    self.blending_ingredients = blending_params[:blending_ingredients]    
  end
  
  def blend
    ok_count = 0
    ingredient_list = []
    
    recipe = Recipe.create(:many_ppl => 1, :title => "test", :difficulty => "easy", :time => 1, :category_id => 1, :text => self.blending_text, :approved => false)
   

    
    Rails.logger.debug "== Blender::blend"
    unless self.blending_ingredients.blank?
      blending_ingredients.split("\n").each do |ingredient|
        if parse_ingredients(ingredient, recipe) 
          ok_count += 1 
        end
        Rails.logger.debug "\n"
      end
    end
    Rails.logger.debug "= Result: #{ok_count}/#{blending_ingredients.split("\n").count}"    
  end
  
  def parse_ingredients ingredient_text, recipe    
  
    Rails.logger.debug "== Blender::parse_ingredients"
    #Rails.logger.debug "= ingredient_text: #{ingredient_text}"
   
    # Removes MINUS "-"
    ingredient_text.gsub!("-","")
    
    # Removes Complements
    ingredient_text.gsub!(/\b(#{STOP_WORDS.join('|')})\b/mi, ' ')
    
    is_valid, measure, quantity = get_measure_and_quantity ingredient_text

    if is_valid
    
      # TODO: Tudo no mesmo GSUB
      ingredient_text.gsub!("#{measure}","")
      ingredient_text.gsub!("#{quantity}","")
      
      # Removes all unecessary spaces
      food_item_name = ingredient_text.split(" ").join(" ")
      
      Rails.logger.debug "Ingredient: #{ingredient_text}"
      
      f_item = FoodItem.create(:name => food_item_name, :price => nil, :certified => false)
      Ingredient.create(:food_item_id => f_item.id, :quantity => quantity, :measure => measure, :recipe_id => recipe.id)
      
    end
    
    return is_valid    
    
  end
  
  def get_measure_and_quantity ingredient_text
  
    Rails.logger.debug "== Blender::get_measure_and_quantity"
    Rails.logger.debug "= ingredient_text: #{ingredient_text}"
    
    quantity = nil
    measure = nil
    is_valid = false    

    if has_any_number?(ingredient_text)  
      split_string = ingredient_text.split(" ") # 4 OR 4KG
      
      # metodo para ver se tem algum numero      
      first_token = split_string.first
      second_token = split_string.second
      
      # Could be: 4 KG; 4KG; 1/4 KG; 2 1/5 KG      
      if( is_digit?(first_token) && !has_a_slash?(first_token) ) # 4 KG or 2 1/5 Kg
        if( has_a_slash?(second_token) ) # 2 1/5 KG
          quantity = first_token.concat(" "+second_token)
          third_token = split_string.third
          measure = third_token unless (third_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(third_token))
          is_valid = true
        else  # its 4 KG
          quantity = first_token
          measure = second_token unless (second_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(second_token))
          is_valid = true     
        end      
      else # Its stuck together or has slash (4Kg or 1/4 KG)
        if(has_a_slash?(first_token) && !is_digit(second_token) ) # its 1/4 KG
          quantity = first_token
          measure = second_token unless (second_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(second_token))
          is_valid = true
        else # Its stuck , 4Kg
          quantity = first_token.gsub(/[^0-9]/, '')
          temp_measure = first_token.gsub(/[^A-Za-z]/, '')
          measure = temp_measure unless (first_token.size > PLAUSIBLE_MEASURE_SIZE) && (!MEASURE_WORDS.include?(temp_measure))
          is_valid = true
        end     
      end 
    
    end
    is_valid ? output = "[Seem Legit]: Quantity: #{quantity} - Measure: #{measure}" : output = "The ingredient does not have quantity"
    Rails.logger.debug "#{output}"
    return is_valid, measure, quantity
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

