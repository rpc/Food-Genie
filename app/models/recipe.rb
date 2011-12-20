class Recipe < ActiveRecord::Base
  has_many :ingredients #, :class_name => "FoodMeasure", :foreign_key => "food_id
  belongs_to :category
  
  
  
end
