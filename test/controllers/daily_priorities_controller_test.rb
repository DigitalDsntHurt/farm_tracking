require 'test_helper'

class DailyPrioritiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_priority = daily_priorities(:one)
  end

  test "should get index" do
    get daily_priorities_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_priority_url
    assert_response :success
  end

  test "should create daily_priority" do
    assert_difference('DailyPriority.count') do
      post daily_priorities_url, params: { daily_priority: { initial: @daily_priority.initial, one: @daily_priority.one, oneexecuted: @daily_priority.oneexecuted, two: @daily_priority.two, twoexecuted: @daily_priority.twoexecuted } }
    end

    assert_redirected_to daily_priority_url(DailyPriority.last)
  end

  test "should show daily_priority" do
    get daily_priority_url(@daily_priority)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_priority_url(@daily_priority)
    assert_response :success
  end

  test "should update daily_priority" do
    patch daily_priority_url(@daily_priority), params: { daily_priority: { initial: @daily_priority.initial, one: @daily_priority.one, oneexecuted: @daily_priority.oneexecuted, two: @daily_priority.two, twoexecuted: @daily_priority.twoexecuted } }
    assert_redirected_to daily_priority_url(@daily_priority)
  end

  test "should destroy daily_priority" do
    assert_difference('DailyPriority.count', -1) do
      delete daily_priority_url(@daily_priority)
    end

    assert_redirected_to daily_priorities_url
  end
end
