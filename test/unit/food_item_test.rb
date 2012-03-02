require 'test_helper'

class FoodItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "name uniqueness" do
    FoodItem.create(:name => "fiambre")
    assert_no_difference 'FoodItem.count' do
      FoodItem.create(:name => "fiambre")
    end
  end
  
  test "must have a name" do
    food_item = FoodItem.new
     assert_no_difference 'FoodItem.count' do
      food_item.save
    end
  end
end
