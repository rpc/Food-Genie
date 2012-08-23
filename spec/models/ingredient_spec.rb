require 'spec_helper'

describe Ingredient do

  it "should not create duplicate food_items" do
  
  	FactoryGirl.create(:food_item, :name => "fiambre")
    fiambre = FactoryGirl.build(:food_item, :name => "fiambre")

    food_item_count_before_new_ingredient = FoodItem.count
    
    # Has to be .new, before_save doesnt work with factory
    ingredient = Ingredient.new(:quantity => "2", :measure => "1", :food_item => fiambre)
    ingredient.save
    ingredient.should be_valid

    assert (food_item_count_before_new_ingredient == FoodItem.count)
  end
  
  it "should not create create food_items without a name" do
    fiambre = FoodItem.new
    #FactoryGirl.create(:ingredient, :food_item => fiambre).should be_valid
  end	

end