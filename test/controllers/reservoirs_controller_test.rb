require 'test_helper'

class ReservoirsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservoir = reservoirs(:one)
  end

  test "should get index" do
    get reservoirs_url
    assert_response :success
  end

  test "should get new" do
    get new_reservoir_url
    assert_response :success
  end

  test "should create reservoir" do
    assert_difference('Reservoir.count') do
      post reservoirs_url, params: { reservoir: { brand: @reservoir.brand, name: @reservoir.name, size_liters: @reservoir.size_liters } }
    end

    assert_redirected_to reservoir_url(Reservoir.last)
  end

  test "should show reservoir" do
    get reservoir_url(@reservoir)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservoir_url(@reservoir)
    assert_response :success
  end

  test "should update reservoir" do
    patch reservoir_url(@reservoir), params: { reservoir: { brand: @reservoir.brand, name: @reservoir.name, size_liters: @reservoir.size_liters } }
    assert_redirected_to reservoir_url(@reservoir)
  end

  test "should destroy reservoir" do
    assert_difference('Reservoir.count', -1) do
      delete reservoir_url(@reservoir)
    end

    assert_redirected_to reservoirs_url
  end
end
