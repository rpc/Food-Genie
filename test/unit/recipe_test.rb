require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  test "Recipe is created" do
    assert_difference('Recipe.count', 1) do     
      recipe = Factory.create(:recipe)
    end
  end
  
  test "Deleting a recipe deletes its ingredients " do
    recipe = Factory.create(:recipe)
    
    ingredient1 = Factory.create(:ingredient)
    ingredient2 = Factory.create(:ingredient) 
    
    recipe.ingredients << ingredient1
    recipe.ingredients << ingredient2

    ingredients_before = Ingredient.count
    recipe_before = Recipe.count

    recipe.destroy

    assert (Ingredient.count == (ingredients_before - 2)) and (Recipe.count == (recipe_before -1))
  end
  
  test "Deleting a recipe deletes its ingredients and orphaned food_items leaving others intact" do
    
    recipe1 = Factory.create(:recipe)
    recipe2 = Factory.create(:recipe)
    
    food_item1 = Factory.create(:food_item)
    food_item2 = Factory.create(:food_item)
    
    ingredient1 = Factory.create(:ingredient, :recipe => recipe1, :food_item => food_item1)
    ingredient2 = Factory.create(:ingredient, :recipe => recipe1, :food_item => food_item2) 
    ingredient3 = Factory.create(:ingredient, :recipe => recipe2, :food_item => food_item2) 
    
    recipe1.ingredients << ingredient1
    recipe1.ingredients << ingredient2
    recipe2.ingredients << ingredient3
    
    ingredients_before = Ingredient.count
    recipe_before = Recipe.count
    food_items_before = FoodItem.count
    
    recipe1.destroy    

    assert ((Ingredient.count == (ingredients_before - 2)) and (Recipe.count == (recipe_before -1)) and (FoodItem.count == (food_items_before - 1)))
    
  end
  
  
end
