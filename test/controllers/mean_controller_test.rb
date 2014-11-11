require 'test_helper'

class MeanControllerTest < ActionController::TestCase
  test "index - it should have a form for resetting the page" do
    get :index
    assert_response :success
    assert_select "#reset_form"
  end

  test "index - it should have a form for updating the mean" do
    get :index
    assert_response :success
    assert_select "#update_form"
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

  test "update for the FIRST time" do
    number = 100
    session[:numbers_looked_at] = 0
    post :update, :number => number
    assert_redirected_to mean_index_path
    assert_equal session[:numbers_looked_at], 1
    assert_equal session[:mean], number
  end

  test "update AFTER the FIRST time" do
    number = 100
    numbers_looked_at = 10
    cur_mean = 100
    session[:numbers_looked_at] = numbers_looked_at
    session[:mean] = cur_mean

    cur_sum = cur_mean * numbers_looked_at

    new_mean = (cur_sum + number) / (numbers_looked_at + 1)
    post :update, :number => number
    assert_redirected_to mean_index_path
    assert_equal session[:numbers_looked_at], (numbers_looked_at + 1)
    assert_equal session[:mean], new_mean
  end
end
