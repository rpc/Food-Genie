require 'test_helper'

class BlendersControllerTest < ActionController::TestCase
  setup do
    @blender = blenders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blenders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blender" do
    assert_difference('Blender.count') do
      post :create, blender: {  }
    end

    assert_redirected_to blender_path(assigns(:blender))
  end

  test "should show blender" do
    get :show, id: @blender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blender
    assert_response :success
  end

  test "should update blender" do
    put :update, id: @blender, blender: {  }
    assert_redirected_to blender_path(assigns(:blender))
  end

  test "should destroy blender" do
    assert_difference('Blender.count', -1) do
      delete :destroy, id: @blender
    end

    assert_redirected_to blenders_path
  end
end
