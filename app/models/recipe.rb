class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :food_items, :through => :ingredients
  belongs_to :category
  
  def match_recipe_with_ingredients ingredient_list
    matched_percent = 0
    unless ingredient_list.blank?
      matched_ingredients = self.food_items & ingredient_list
      matched_percent = (matched_ingredients.size*100)/ingredient_list.size
    end
    return matched_percent
  end
  
end
