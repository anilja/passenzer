require 'test_helper'

class BusformsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @busform = busforms(:one)
  end

  test "should get index" do
    get busforms_url
    assert_response :success
  end

  test "should get new" do
    get new_busform_url
    assert_response :success
  end

  test "should create busform" do
    assert_difference('Busform.count') do
      post busforms_url, params: { busform: { description: @busform.description, title: @busform.title } }
    end

    assert_redirected_to busform_url(Busform.last)
  end

  test "should show busform" do
    get busform_url(@busform)
    assert_response :success
  end

  test "should get edit" do
    get edit_busform_url(@busform)
    assert_response :success
  end

  test "should update busform" do
    patch busform_url(@busform), params: { busform: { description: @busform.description, title: @busform.title } }
    assert_redirected_to busform_url(@busform)
  end

  test "should destroy busform" do
    assert_difference('Busform.count', -1) do
      delete busform_url(@busform)
    end

    assert_redirected_to busforms_url
  end
end
