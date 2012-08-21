require 'test_helper'

class BlenderFormsControllerTest < ActionController::TestCase
  setup do
    @blender_form = blender_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blender_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blender_form" do
    assert_difference('BlenderForm.count') do
      post :create, blender_form: {  }
    end

    assert_redirected_to blender_form_path(assigns(:blender_form))
  end

  test "should show blender_form" do
    get :show, id: @blender_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blender_form
    assert_response :success
  end

  test "should update blender_form" do
    put :update, id: @blender_form, blender_form: {  }
    assert_redirected_to blender_form_path(assigns(:blender_form))
  end

  test "should destroy blender_form" do
    assert_difference('BlenderForm.count', -1) do
      delete :destroy, id: @blender_form
    end

    assert_redirected_to blender_forms_path
  end
end
