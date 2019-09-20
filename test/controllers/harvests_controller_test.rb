require 'test_helper'

class HarvestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @harvest = harvests(:one)
  end

  test "should get index" do
    get harvests_url
    assert_response :success
  end

  test "should get new" do
    get new_harvest_url
    assert_response :success
  end

  test "should create harvest" do
    assert_difference('Harvest.count') do
      post harvests_url, params: { harvest: { completed: @harvest.completed, crop_id: @harvest.crop_id, customer_id: @harvest.customer_id, date: @harvest.date, instructions: @harvest.instructions, order_id: @harvest.order_id, qty_oz: @harvest.qty_oz, time: @harvest.time } }
    end

    assert_redirected_to harvest_url(Harvest.last)
  end

  test "should show harvest" do
    get harvest_url(@harvest)
    assert_response :success
  end

  test "should get edit" do
    get edit_harvest_url(@harvest)
    assert_response :success
  end

  test "should update harvest" do
    patch harvest_url(@harvest), params: { harvest: { completed: @harvest.completed, crop_id: @harvest.crop_id, customer_id: @harvest.customer_id, date: @harvest.date, instructions: @harvest.instructions, order_id: @harvest.order_id, qty_oz: @harvest.qty_oz, time: @harvest.time } }
    assert_redirected_to harvest_url(@harvest)
  end

  test "should destroy harvest" do
    assert_difference('Harvest.count', -1) do
      delete harvest_url(@harvest)
    end

    assert_redirected_to harvests_url
  end
end
