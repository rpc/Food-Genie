require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Creation OK" do
  debugger
    recipe = Factory.create(:recipe)
    
    puts recipe.inspect
    puts Recipe.all
    assert Recipe.count > 1
    
  end
end
