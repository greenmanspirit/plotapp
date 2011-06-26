require 'test_helper'

class PlotpointsControllerTest < ActionController::TestCase
  setup do
    @plotpoint = plotpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plotpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plotpoint" do
    assert_difference('Plotpoint.count') do
      post :create, :plotpoint => @plotpoint.attributes
    end

    assert_redirected_to plotpoint_path(assigns(:plotpoint))
  end

  test "should show plotpoint" do
    get :show, :id => @plotpoint.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @plotpoint.to_param
    assert_response :success
  end

  test "should update plotpoint" do
    put :update, :id => @plotpoint.to_param, :plotpoint => @plotpoint.attributes
    assert_redirected_to plotpoint_path(assigns(:plotpoint))
  end

  test "should destroy plotpoint" do
    assert_difference('Plotpoint.count', -1) do
      delete :destroy, :id => @plotpoint.to_param
    end

    assert_redirected_to plotpoints_path
  end
end
