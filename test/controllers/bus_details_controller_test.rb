require 'test_helper'

class BusDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bus_detail = bus_details(:one)
  end

  test "should get index" do
    get bus_details_url
    assert_response :success
  end

  test "should get new" do
    get new_bus_detail_url
    assert_response :success
  end

  test "should create bus_detail" do
    assert_difference('BusDetail.count') do
      post bus_details_url, params: { bus_detail: { destination: @bus_detail.destination, destination_lang: @bus_detail.destination_lang, destination_lat: @bus_detail.destination_lat, name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.source, source_lang: @bus_detail.source_lang, source_lat: @bus_detail.source_lat } }
    end

    assert_redirected_to bus_detail_url(BusDetail.last)
  end

  test "should show bus_detail" do
    get bus_detail_url(@bus_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_bus_detail_url(@bus_detail)
    assert_response :success
  end

  test "should update bus_detail" do
    patch bus_detail_url(@bus_detail), params: { bus_detail: { destination: @bus_detail.destination, destination_lang: @bus_detail.destination_lang, destination_lat: @bus_detail.destination_lat, name: @bus_detail.name, number: @bus_detail.number, source: @bus_detail.source, source_lang: @bus_detail.source_lang, source_lat: @bus_detail.source_lat } }
    assert_redirected_to bus_detail_url(@bus_detail)
  end

  test "should destroy bus_detail" do
    assert_difference('BusDetail.count', -1) do
      delete bus_detail_url(@bus_detail)
    end

    assert_redirected_to bus_details_url
  end
end
