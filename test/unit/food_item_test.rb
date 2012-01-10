require 'test_helper'

class FoodItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "name uniqueness" do
    FoodItem.create(:name => "fiambre")
    FoodItem.create(:name => "fiambre")
    assert FoodItem.count == 1
  end
end
