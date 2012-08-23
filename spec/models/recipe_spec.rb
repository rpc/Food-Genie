require 'spec_helper'

describe Recipe do

	it "should create a valid recipe" do 
		recipe = FactoryGirl.create(:recipe)
		recipe.should be_valid
		assert (Recipe.last.title == recipe.title)
  end

  it "should delete every recipe ingredient if the recipe itself is destroyed" do
    recipe = FactoryGirl.create(:recipe)
    
    ingredient1 = FactoryGirl.create(:ingredient)
    ingredient2 = FactoryGirl.create(:ingredient) 
    
    recipe.ingredients << ingredient1
    recipe.ingredients << ingredient2

    ingredients_before = Ingredient.count
    recipe_before = Recipe.count

    recipe.destroy

    assert (Ingredient.count == (ingredients_before - 2)) and (Recipe.count == (recipe_before -1))
  end

	it "should destroy every recipe ingredient and orphaned food_items BUT leaves the remaining intact" do
    
    recipe1 = FactoryGirl.create(:recipe)
    recipe2 = FactoryGirl.create(:recipe)
    
    food_item1 = FactoryGirl.create(:food_item)
    food_item2 = FactoryGirl.create(:food_item)
    
    ingredient1 = FactoryGirl.create(:ingredient, :recipe => recipe1, :food_item => food_item1)
    ingredient2 = FactoryGirl.create(:ingredient, :recipe => recipe1, :food_item => food_item2) 
    ingredient3 = FactoryGirl.create(:ingredient, :recipe => recipe2, :food_item => food_item2) 
    
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