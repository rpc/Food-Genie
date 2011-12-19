class Recipe < ActiveRecord::Base
  has_many :food_measure #, :class_name => "FoodMeasure", :foreign_key => "food_id
  
end
