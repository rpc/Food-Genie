class Recipe < ActiveRecord::Base

  attr_accessible :ingredients, :many_ppl, :title, :effort_id, :time, :category_id, :text, :approved, :ingredients_attributes

  has_many :ingredients, :dependent => :destroy
  has_many :food_items, :through => :ingredients
  belongs_to :category

  accepts_nested_attributes_for :ingredients, allow_destroy: true, :reject_if => lambda { |a| a[:quantity].blank? || a[:measure].blank? }
  
  validates_uniqueness_of :title
  
  validates_presence_of :title
  validates_presence_of :effort_id
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
