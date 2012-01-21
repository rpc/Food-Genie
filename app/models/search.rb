class Search
  include ActiveModel
  include ActiveModel::Validations
  
  attr_accessor :difficulty, :time, :category, :search_field, :result_find
  attr_accessor :info
  

  validates_presence_of :difficulty, :message => DIFICULTY_PARAM_ERR
  validates_presence_of :time, :message => TIME_PARAM_ERR
  validates_presence_of :category, :message => CATEGORY_PARAM_ERR
  
  def initialize(search_options)
    
    Rails.logger.debug "** Search::Initialize"   
    Rails.logger.debug "* search_options: #{search_options.inspect}"    

		unless search_options.blank?
			self.difficulty = search_options[:difficulty]
			self.time = search_options[:time]
			self.category = search_options[:category]
		end
    
  end 

	def preform_search search_field
		Rails.logger.debug "** Search::PreformSearch"
		Rails.logger.debug "* search_field: #{search_field.inspect}"

		result_set = nil

		# Searches unless search_field is blank/nil OR the search_options are invalid.
    unless search_field.blank? or !errors.blank?      
      result_set = parse_entry_string search_field.downcase
      @result_find = find_in_result_set result_set
    end
	end

  def parse_entry_string entry_string
     # entry_array = entry_string.gsub(/[^A-Za-z\+\-]/, ' ').split(' ').delete_if {|word| word.end_with?("-") or  word.end_with?("+") }
     # Operations: Leaves only chars; Breaks on Spaces; Singularizes each word.
    entry_array = entry_string.gsub(/[^A-Za-z]/, ' ').split(' ') #.map{|ingredient| ingredient.singularize}
  end
  
  def find_in_result_set result_set

    Rails.logger.debug "** Search:find_in_result"
    Rails.logger.debug "* Result set: #{result_set}"

		# Recipe filter query
		recipe_query = Recipe.joins(:ingredients => :food_item)
		recipe_or_query = build_query_with_or("food_items.name",result_set)
		recipe_query = recipe_query.where(recipe_or_query)
		recipe_query = recipe_query.select("DISTINCT recipes.*")
    
    # Ingredients Filter
    ingredient_or_query = build_query_with_or("name",result_set)
    ingredients_query = FoodItem.where(ingredient_or_query)
    
    Rails.logger.debug "* Recipe Query: #{recipe_query.to_sql}"
    Rails.logger.debug "* Ingredient Query: #{ingredients_query.to_sql}"
    
    rank_recipe_hash = rank_recipes(recipe_query, ingredients_query)
    Rails.logger.debug "* Recipes Ranked: #{rank_recipe_hash}"
    
    sorted_rank_recipe_hash = sort_recipes(rank_recipe_hash)    
    Rails.logger.debug "* Recipes Ranked and Sorted: #{sorted_rank_recipe_hash}"
  end
  
  def rank_recipes recipe_query, ingredients_query
    recipes_ranked = {}
    
    recipe_query.each do |recipe|
      debugger  
      match_percent = recipe.match_recipe_with_ingredients ingredients_query
      if recipes_ranked.key?(match_percent) 
        recipes_ranked[match_percent] << recipe 
      else
        recipes_ranked[match_percent] = []
        recipes_ranked[match_percent] << recipe 
      end
      Rails.logger.debug "* Match percent #{match_percent}"
    end    
  end
  
  def sort_recipes rank_recipe_hash
    return Hash[rank_recipe_hash.sort]
  end
  
  private
  def build_query_with_or attribute, compare_list
    or_query = ""
    unless attribute.blank?
      compare_list.each_with_index do |item, index|      
        or_query << "#{attribute} LIKE '%#{item}%' OR " if index+1 != compare_list.count
        or_query << "#{attribute} LIKE '%#{item}%'" if index+1 == compare_list.count
      end
    end
    return or_query
  end
  

  
end

