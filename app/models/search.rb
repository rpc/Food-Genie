class Search
  include ActiveModel
  include ActiveModel::Validations
  
  attr_accessor :dificulty, :time, :category, :search_field, :result_find
  attr_accessor :info
  

  validates_presence_of :dificulty, :message => DIFICULTY_PARAM_ERR
  validates_presence_of :time, :message => TIME_PARAM_ERR
  validates_presence_of :category, :message => CATEGORY_PARAM_ERR
  
  def initialize(search_field, search_options )
    
    Rails.logger.debug "** Search::Initialize"
    Rails.logger.debug "* search_field: #{search_field.inspect}"
    Rails.logger.debug "* search_options: #{search_options.inspect}"
    
    result_set = nil
   
    # Searches unless que search_query is blank/nil OR the search_options are invalid.
    unless search_field.blank? or !errors.blank?      
      
      result_set = parse_entry_string search_field#.downcase
      @result_find = find_in_result_set result_set
    end
  end 
  
  def find_in_result_set result_set

    Rails.logger.debug "** Search:find_in_result"
    Rails.logger.debug "* Result set: #{result_set}"
    query = Recipe.joins(:ingredients => :food_item)
    query.where("food_items.name" => result_set)
    
    Rails.logger.debug "* Query: #{query.to_sql}"
  end
  
  def parse_entry_string entry_string
     # entry_array = entry_string.gsub(/[^A-Za-z\+\-]/, ' ').split(' ').delete_if {|word| word.end_with?("-") or  word.end_with?("+") }
     # Operations: Leaves only chars; Breaks on Spaces; Singularizes each word.
    entry_array = entry_string.gsub(/[^A-Za-z]/, ' ').split(' ') #.map{|ingredient| ingredient.singularize}
  end
  
end

