require 'test_helper'

class FoodMeasuresControllerTest < ActionController::TestCase
  setup do
    @food_measure = food_measures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_measures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_measure" do
    assert_difference('FoodMeasure.count') do
      post :create, food_measure: @food_measure.attributes
    end

    assert_redirected_to food_measure_path(assigns(:food_measure))
  end

  test "should show food_measure" do
    get :show, id: @food_measure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_measure.to_param
    assert_response :success
  end

  test "should update food_measure" do
    put :update, id: @food_measure.to_param, food_measure: @food_measure.attributes
    assert_redirected_to food_measure_path(assigns(:food_measure))
  end

  test "should destroy food_measure" do
    assert_difference('FoodMeasure.count', -1) do
      delete :destroy, id: @food_measure.to_param
    end

    assert_redirected_to food_measures_path
  end
end
