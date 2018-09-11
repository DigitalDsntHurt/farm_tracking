require 'test_helper'

class SeedFlatUpdatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seed_flat_update = seed_flat_updates(:one)
  end

  test "should get index" do
    get seed_flat_updates_url
    assert_response :success
  end

  test "should get new" do
    get new_seed_flat_update_url
    assert_response :success
  end

  test "should create seed_flat_update" do
    assert_difference('SeedFlatUpdate.count') do
      post seed_flat_updates_url, params: { seed_flat_update: { destination_system_id: @seed_flat_update.destination_system_id, notes: @seed_flat_update.notes, origin_system_id: @seed_flat_update.origin_system_id, seed_flat_id: @seed_flat_update.seed_flat_id, update_datetime: @seed_flat_update.update_datetime, update_type: @seed_flat_update.update_type } }
    end

    assert_redirected_to seed_flat_update_url(SeedFlatUpdate.last)
  end

  test "should show seed_flat_update" do
    get seed_flat_update_url(@seed_flat_update)
    assert_response :success
  end

  test "should get edit" do
    get edit_seed_flat_update_url(@seed_flat_update)
    assert_response :success
  end

  test "should update seed_flat_update" do
    patch seed_flat_update_url(@seed_flat_update), params: { seed_flat_update: { destination_system_id: @seed_flat_update.destination_system_id, notes: @seed_flat_update.notes, origin_system_id: @seed_flat_update.origin_system_id, seed_flat_id: @seed_flat_update.seed_flat_id, update_datetime: @seed_flat_update.update_datetime, update_type: @seed_flat_update.update_type } }
    assert_redirected_to seed_flat_update_url(@seed_flat_update)
  end

  test "should destroy seed_flat_update" do
    assert_difference('SeedFlatUpdate.count', -1) do
      delete seed_flat_update_url(@seed_flat_update)
    end

    assert_redirected_to seed_flat_updates_url
  end
end
