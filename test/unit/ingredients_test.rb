require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  test "Ensure doesnt save duplicate FoodItems" do
  
    FoodItem.create(:name => "fiambre")
    fiambre = FoodItem.new(:name => "fiambre")
    
    assert_no_difference 'Ingredient.count' do
      ingredient =Ingredient.new(:quantity => "2", :measure => "1", :food_item => fiambre)
      ingredient.save
    end   
  end
  
  test "Ensure doenst insert food item without name" do
    fiambre = FoodItem.new
    
    assert_no_difference 'Ingredient.count' do
      ing = Ingredient.new(:food_item => fiambre)
      ing.save
    end
  end
  
end
