require 'test_helper'

class FarmOpsDosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @farm_ops_do = farm_ops_dos(:one)
  end

  test "should get index" do
    get farm_ops_dos_url
    assert_response :success
  end

  test "should get new" do
    get new_farm_ops_do_url
    assert_response :success
  end

  test "should create farm_ops_do" do
    assert_difference('FarmOpsDo.count') do
      post farm_ops_dos_url, params: { farm_ops_do: { crop: @farm_ops_do.crop, customer: @farm_ops_do.customer, date: @farm_ops_do.date, variety: @farm_ops_do.variety, verb: @farm_ops_do.verb } }
    end

    assert_redirected_to farm_ops_do_url(FarmOpsDo.last)
  end

  test "should show farm_ops_do" do
    get farm_ops_do_url(@farm_ops_do)
    assert_response :success
  end

  test "should get edit" do
    get edit_farm_ops_do_url(@farm_ops_do)
    assert_response :success
  end

  test "should update farm_ops_do" do
    patch farm_ops_do_url(@farm_ops_do), params: { farm_ops_do: { crop: @farm_ops_do.crop, customer: @farm_ops_do.customer, date: @farm_ops_do.date, variety: @farm_ops_do.variety, verb: @farm_ops_do.verb } }
    assert_redirected_to farm_ops_do_url(@farm_ops_do)
  end

  test "should destroy farm_ops_do" do
    assert_difference('FarmOpsDo.count', -1) do
      delete farm_ops_do_url(@farm_ops_do)
    end

    assert_redirected_to farm_ops_dos_url
  end
end
