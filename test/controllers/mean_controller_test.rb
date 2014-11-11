require 'test_helper'

class MeanControllerTest < ActionController::TestCase

  test "index - it should have a form for updating the mean" do
    get :index
    assert_response :success
    assert_select "form"
  end

  test "index - WITHOUT a previous mean calculated" do
    session[:numbers_looked_at] = 0
    get :index
    assert_response :success
    # It show the mean, which is initialized to 0
    assert_equal assigns(:mean), 0
  end

  test "index - WITH a previous mean calculated" do
    session[:numbers_looked_at] = 1
    previous_mean = 100
    session[:mean] = previous_mean
    get :index
    assert_response :success
    # It show the mean, which is initialized to 0
    assert_equal assigns(:mean), previous_mean
  end

  test "should get update" do
    post :update
    assert_redirected_to mean_index_path
  end

end
