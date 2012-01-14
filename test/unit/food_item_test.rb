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
end
