require 'spec_helper'

describe "RecipeCreations", :js => true do

	it "should add a new ingredient box"	do
		visit new_recipe_path
		click_on "Add Ingredient"
		page.should have_content("Quantidade") 
	end

	it "should remove an existing ingredient box"	do
		visit new_recipe_path
		click_on "Add Ingredient"
		page.should have_content("Quantidade") 
		click_on "Remove"
		!page.should have_content("Quantidade") 
	end

	it "should not create empty recipe." do
		visit new_recipe_path
		click_button "Create Recipe"
		#save_and_open_page
		page.should have_content("errors prohibited this recipe from being saved") 
	end

end
