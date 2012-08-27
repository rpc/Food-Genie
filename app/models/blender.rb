class Blender
  
  STOP_WORDS = [" de "," com "]
  MEASURE_WORDS = ["colheres","pacote","quarts","teaspoon","cups","tablespoons","ounces","ounce"]
  PLAUSIBLE_MEASURE_SIZE = 4
  
  attr_accessor :blender_form

  def initialize(blender_form)
    self.blender_form = blender_form
  end
  
  def blend
    ok_count = 0
    ingredient_list = []
    
    recipe = Recipe.new(many_ppl:       self.blender_form.many_ppl,
                           title:       self.blender_form.title, 
                           effort_id:   self.blender_form.effort, 
                           time:        self.blender_form.time, 
                           category_id: self.blender_form.category, 
                           text:        self.blender_form.blending_text, 
                           approved: false)
    
    # Iterates through every ingredient in the form
    unless self.blender_form.blending_ingredients.blank?
      self.blender_form.blending_ingredients.split("\n").each do |ingredient|
        # Digests each ingredient, and assigns it to the recipe.
        # If the function does not understand the ingredient, returns false
        if parse_ingredients(ingredient, recipe) 
          ok_count += 1 
        end
        Rails.logger.debug "\n"
      end
    end
    
    Rails.logger.debug "= Result: #{ok_count}/#{self.blender_form.blending_ingredients.split("\n").count}"  
    return recipe
  end
  
  # Process's and ingredient line
  # + Removes Hiifen (-)
  # + Removes specific words (see STOP_WORDS) 
  # + Extracts the measure, quantity, ingredient name
  def parse_ingredients ingredient_line, recipe  
    Rails.logger.debug "== Blender::parse_ingredients"
   
    # Removes hifen "-"
    ingredient_line.gsub!("-","")    
    # Removes Complementary Words
    ingredient_line.gsub!(/\b(#{STOP_WORDS.join('|')})\b/mi, ' ')
    
    # Given a ingredient line, extracts the: measure, quantity, ingredient name
    measure, quantity, ingredient = get_measure_quantity_and_ingredient ingredient_line.downcase
           
    Rails.logger.debug "* Extracted Ingredient: Quant:(#{quantity}) Meas:(#{measure}) Name:(#{ingredient})"
    
    add_ingredient_to_recipe quantity, measure, ingredient, recipe 
    # Returns true if could understand and extract the measure and quantity
    return !measure.nil? && !quantity.nil?
  end
  
  # Adds an ingredient to the main recipe
  # + Creates a FoodItem
  # + Creates an ingredient with the quantity, measure and the food_item itself
  # + Adds the ingredient to the recipe
  def add_ingredient_to_recipe quantity, measure, food_item_name, recipe  
    food_item = FoodItem.new(:name => food_item_name, :price => nil)
    ingredient = Ingredient.new(:food_item => food_item, :quantity => quantity, :measure => measure, :recipe_id => recipe.id)
    recipe.ingredients << ingredient
  end
  
  # Extracts the measure, quantity, ingredient name from a ingredient line
  # E.g.: 1kg strawberries => 1, kg, strawberries
  # Can parse the following example cases:
  # 4Kg sugar
  # 1/4 KG sour cream 
  # 2 1/5 KG strawberries
  def get_measure_quantity_and_ingredient ingredient_line
  
    Rails.logger.debug "** Blender::get_measure_and_quantity"
    Rails.logger.debug "* ingredient_line: #{ingredient_line}"
    
    quantity = nil
    measure = nil   
    ingredient = []
    split_string = ingredient_line.split(" ")

    if has_any_number?(ingredient_line) and  split_string.size > 1      
      first_token = split_string.shift
      second_token = split_string.shift
      
      # the first token, HAS a number and IS NOT a slash
      # could be: 4 KG; 4KG; 1/4 KG; 2 1/5 KG
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
        if(has_a_slash?(first_token) && !is_digit?(second_token) ) # its 1/4 KG
          quantity = first_token
          measure = validate_measure second_token, ingredient          
        else # Its stuck , 4Kg
          quantity = first_token.gsub(/[^0-9]/, '')
          temp_measure = first_token.gsub(/[^A-Za-z]/, '')
          ingredient << second_token
          measure = validate_measure temp_measure, ingredient          
        end      
      end 
    end
    
    ingredient << split_string
    return measure, quantity, ingredient.join(" ")
  end
  
  private  
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
