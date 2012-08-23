require 'spec_helper'

describe FoodItem do

	it "should have uniq name" do
		FactoryGirl.create(:food_item, :name => "fiambre")
    FactoryGirl.build(:food_item, :name => "fiambre").should_not be_valid
  end
  
  it "should create food item only if it has a name" do
    FoodItem.new.should_not be_valid
  end

end