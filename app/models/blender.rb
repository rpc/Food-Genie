class Blender

  include ActiveModel
  include ActiveModel::Validations
  
  STOP_WORDS = [" de "," com "]
  PLAUSIBLE_MEASURE_SIZE = 3
  
  attr_accessor :blending_text, :blending_ingredients
  validates_presence_of :blending_ingredients, :message => "Cant blend withou ingredients"
  validates_presence_of :blending_text, :message => "You must provide a text"
  
  def initialize(blending_params)
    self.blending_text = blending_params[:blending_text]
    self.blending_ingredients = blending_params[:blending_ingredients]
  end
  
  def blend
    puts "entering: #{blending_ingredients}"
    debugger
    puts "ex: #{blending_ingredients}"    
  end
  
  def parse_ingredients ingredient_text
  
    # Removes SLASH "-"
    ingredient_text.gsub!("-","")
    
    # Removes Complements
    ingredient_text.gsub!(/\b(#{STOP_WORDS.join('|')})\b/mi, ' ')
    
    
    
  end
  
  def self.get_quantity ingredient_text
    quantity = nil
    measure = nil
    is_valid = false
    if self.has_any_number?(ingredient_text)  
      split_string = ingredient_text.split(" ") # 4 OR 4KG

      
      # metodo para ver se tem algum numero
      
      first_token = split_string.first
      second_token = split_string.second
      
      if self.is_digit?(first_token) # Then its 4
        quantity = first_token
        measure = second_token
        is_valid = true unless (measure.size > PLAUSIBLE_MEASURE_SIZE)
      else # its 4KG needs to get the quantity
      debugger
        quantity = first_token.gsub(/[^0-9]/, '')
        measure = first_token.gsub(/[^A-Za-z]/, '')
        is_valid = true unless (measure.size > PLAUSIBLE_MEASURE_SIZE)
      end      
    end
    
    is_valid ? output = "[Seem Legit]: Quantity: #{quantity} - Measure: #{measure}" : output = "The ingredient does not have quantity"
    puts output
    return is_valid
  end
  
  #private 
  def self.is_digit? str
    begin Float(str) ; true end rescue false  
  end
  
  def self.has_any_number? str
    !(str =~ /\d/).nil?
  end
  

end

