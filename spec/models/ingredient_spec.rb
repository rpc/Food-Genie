require 'spec_helper'

describe Ingredient do

  it "should not create duplicate food_items" do
  
  	FactoryGirl.create(:food_item, :name => "fiambre")
    fiambre = FactoryGirl.build(:food_item, :name => "fiambre")

    food_item_count_before_new_ingredient = FoodItem.count

    ingredient = FactoryGirl.create(:ingredient, :food_item => fiambre)

    ingredient.should be_valid

    # No change
    assert (food_item_count_before_new_ingredient == FoodItem.count)
  end
  
  it "should create a new food item if it does not exist" do

    food_item = FactoryGirl.build(:food_item, :name => "queijo")
    food_item.should be_valid

    food_item_count_before_new_ingredient = FoodItem.count

    ingredient = FactoryGirl.create(:ingredient, :food_item => food_item)

    ingredient.should be_valid
    assert(FoodItem.count > food_item_count_before_new_ingredient && FoodItem.last.name == food_item.name )
  end	

end