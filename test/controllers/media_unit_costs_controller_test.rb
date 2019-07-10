require 'test_helper'

class MediaUnitCostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @media_unit_cost = media_unit_costs(:one)
  end

  test "should get index" do
    get media_unit_costs_url
    assert_response :success
  end

  test "should get new" do
    get new_media_unit_cost_url
    assert_response :success
  end

  test "should create media_unit_cost" do
    assert_difference('MediaUnitCost.count') do
      post media_unit_costs_url, params: { media_unit_cost: { date: @media_unit_cost.date, media: @media_unit_cost.media, notes: @media_unit_cost.notes, unit_cost: @media_unit_cost.unit_cost } }
    end

    assert_redirected_to media_unit_cost_url(MediaUnitCost.last)
  end

  test "should show media_unit_cost" do
    get media_unit_cost_url(@media_unit_cost)
    assert_response :success
  end

  test "should get edit" do
    get edit_media_unit_cost_url(@media_unit_cost)
    assert_response :success
  end

  test "should update media_unit_cost" do
    patch media_unit_cost_url(@media_unit_cost), params: { media_unit_cost: { date: @media_unit_cost.date, media: @media_unit_cost.media, notes: @media_unit_cost.notes, unit_cost: @media_unit_cost.unit_cost } }
    assert_redirected_to media_unit_cost_url(@media_unit_cost)
  end

  test "should destroy media_unit_cost" do
    assert_difference('MediaUnitCost.count', -1) do
      delete media_unit_cost_url(@media_unit_cost)
    end

    assert_redirected_to media_unit_costs_url
  end
end
