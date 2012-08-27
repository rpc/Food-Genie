class Search

  attr_accessor :effort_id, :time, :category, :search_field

  def initialize(attributes = {})
    
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

	def preform_search

		Rails.logger.debug "** Search::PreformSearch"
		Rails.logger.debug "* search_field: #{search_field}"
		result_find = []

		# Searches unless search_field is blank/nil OR the search_options are invalid.
    unless search_field.blank?
      result_set = parse_entry_string search_field.downcase
      result_find = find_in_result_set result_set
    end
    return result_find
	end

  def parse_entry_string entry_string
     # entry_array = entry_string.gsub(/[^A-Za-z\+\-]/, ' ').split(' ').delete_if {|word| word.end_with?("-") or  word.end_with?("+") }
     # Operations: Leaves only chars; Breaks on Spaces; Singularizes each word.
    entry_string.gsub(/[^A-Za-z]/, ' ').split(' ').map{|ingredient| ingredient.singularize}
  end
  
  def find_in_result_set result_set
    Rails.logger.debug "** Search:find_in_result"
    Rails.logger.debug "* Result set: #{result_set}"

		# Recipe filter query - Buildes a query that uses the search_options and ingredients passed
		recipe_query = Recipe.joins(:ingredients => :food_item)
		recipe_or_query = build_query_with_or("food_items.name",result_set)
		recipe_query = recipe_query.where(recipe_or_query)
		recipe_query = recipe_query.select("DISTINCT recipes.*")
		recipe_query = recipe_query.order("recipes.time asc")
		
		# Ingredient Options
		recipe_query = recipe_query.where(:category_id => self.category)
  	recipe_query = recipe_query.where("time <= ?",self.time)
  	recipe_query = recipe_query.where("effort_id <= ?",self.effort_id)
    
    # Ingredients Filter
    ingredient_or_query = build_query_with_or("name",result_set)
    ingredients_query = FoodItem.where(ingredient_or_query)
    
    Rails.logger.debug "* Recipe Query: #{recipe_query.to_sql}"
    Rails.logger.debug "* Ingredient Query: #{ingredients_query.to_sql}"
    
    # Ranks the recipes based on how it matchs the ingredients
    rank_recipe_hash = rank_recipes(recipe_query, ingredients_query, result_set.size)
    Rails.logger.debug "* Recipes Ranked: #{rank_recipe_hash}"
 
    # Sorts the ranked hash based on the biggest match
    sorted_rank_recipe_hash = sort_recipes(rank_recipe_hash)    
    Rails.logger.debug "* Recipes Ranked and Sorted: #{sorted_rank_recipe_hash}"

    return sorted_rank_recipe_hash
  end
  
  def rank_recipes recipe_query, ingredients_query, number_of_raw_ingredients
    recipes_ranked = {}    
    recipe_query.each do |recipe|
      match_percent = recipe.match_recipe_with_ingredients(ingredients_query,number_of_raw_ingredients)
      if recipes_ranked.key?(match_percent) 
        recipes_ranked[match_percent] << recipe 
      else # If its the first time that has this rank, creates a array to store
        recipes_ranked[match_percent] = []
        recipes_ranked[match_percent] << recipe 
      end
      Rails.logger.debug "* Match percent #{match_percent}"
    end 
    return recipes_ranked 
  end
  
  def sort_recipes rank_recipe_hash
    return Hash[rank_recipe_hash.sort.reverse]
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

