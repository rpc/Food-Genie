require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  test "Ensure doesnt save duplicate FoodItems" do
    FoodItem.create(:name => "fiambre")
        
    fiambre = FoodItem.new(:name => "fiambre")
    ingredient =Ingredient.new(:quantity => "2", :measure => "1", :food_item => fiambre)
    ingredient.save
    
    assert !ingredient.food_item_id.nil?
  end
  
end
