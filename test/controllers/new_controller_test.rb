require 'test_helper'

class NewControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get new_home_url
    assert_response :success
  end

  test "should get cabs" do
    get new_cabs_url
    assert_response :success
  end

  test "should get citybus" do
    get new_citybus_url
    assert_response :success
  end

  test "should get metro" do
    get new_metro_url
    assert_response :success
  end

  test "should get bustickets" do
    get new_bustickets_url
    assert_response :success
  end

  test "should get train" do
    get new_train_url
    assert_response :success
  end

  test "should get flights" do
    get new_flights_url
    assert_response :success
  end

end
