require 'test_helper'

class GenieSearchFormsControllerTest < ActionController::TestCase
  setup do
    @genie_search_form = genie_search_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genie_search_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genie_search_form" do
    assert_difference('GenieSearchForm.count') do
      post :create, genie_search_form: {  }
    end

    assert_redirected_to genie_search_form_path(assigns(:genie_search_form))
  end

  test "should show genie_search_form" do
    get :show, id: @genie_search_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genie_search_form
    assert_response :success
  end

  test "should update genie_search_form" do
    put :update, id: @genie_search_form, genie_search_form: {  }
    assert_redirected_to genie_search_form_path(assigns(:genie_search_form))
  end

  test "should destroy genie_search_form" do
    assert_difference('GenieSearchForm.count', -1) do
      delete :destroy, id: @genie_search_form
    end

    assert_redirected_to genie_search_forms_path
  end
end
