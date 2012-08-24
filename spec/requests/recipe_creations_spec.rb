require 'spec_helper'

describe "RecipeCreations", :js => true do

	it "should have all necessary fields to build an ingredient" do
		visit new_recipe_path
		click_on "Add Ingredient"
		page.should have_content("Quantity") 		
		page.should have_content("Measure/Units")
		click_on "Add Item"
		page.should have_content("Ingredient Name") 
		page.should have_content("Price") 
		page.should have_content("Certified")
	end	

	it "should create a valid recipe without ingredients"	do
		visit new_recipe_path
		fill_basic_recipe_body
		click_button "Create Recipe"
		page.should have_content("Recipe was successfully created.")
	end

	it "should create a valid recipe without ingredients even it the used has empty ones"	do
		visit new_recipe_path
		fill_basic_recipe_body
		click_on "Add Ingredient"
		click_button "Create Recipe"
		page.should have_content("Recipe was successfully created.")
	end	

	it "should create a valid recipe with ONE ingredient"	do
		visit new_recipe_path
		fill_basic_recipe_body		
		fill_in('Quantity', :with => '400')
		fill_in('Measure/Units', :with => 'g')
		click_button "Create Recipe"
		page.should have_content("Recipe was successfully created.") 
	end

	it "should add a new ingredient box"	do
		visit new_recipe_path
		click_on "Add Ingredient"
		page.should have_content("Quantity") 
	end

	it "should remove an existing ingredient box"	do
		visit new_recipe_path
		click_on "Add Ingredient"
		page.should have_content("Quantity") 
		click_on "Remove"
		!page.should have_content("Quantity") 
	end

	it "should not create empty recipe." do
		visit new_recipe_path
		click_button "Create Recipe"
		#save_and_open_page
		page.should have_content("errors prohibited this recipe from being saved") 
	end

	def fill_basic_recipe_body
		fill_in('Many ppl', :with => '4')
		fill_in('Title', :with => "My First Recipe #{rand(199)}")
		fill_in('Effort', :with => '4')
		fill_in('Time', :with => '35')
		select('Dish', :from => 'Category')
		fill_in('Text', :with => 'blend blend blend')
	end

end
