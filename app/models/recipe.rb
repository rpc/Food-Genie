class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :food_items, :through => :ingredients
  belongs_to :category
  
  validates_uniqueness_of :title
  
  validates_presence_of :title
  validates_presence_of :difficulty
  validates_presence_of :time
  validates_presence_of :category_id  
  
  def match_recipe_with_ingredients ingredient_list, number_of_raw_ingredients
    matched_percent = 0
    unless ingredient_list.blank?
      matched_ingredients = self.food_items & ingredient_list
      matched_percent = (matched_ingredients.size*100)/number_of_raw_ingredients
      matched_percent = 100 if matched_percent > 100
    end
    return matched_percent
  end
  
 
  
end
