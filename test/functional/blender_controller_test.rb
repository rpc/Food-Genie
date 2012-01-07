require 'test_helper'

class BlenderControllerTest < ActionController::TestCase
  test "should get blend" do
    get :blend
    assert_response :success
  end

end
