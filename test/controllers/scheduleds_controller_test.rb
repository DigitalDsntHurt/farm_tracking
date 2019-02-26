require 'test_helper'

class ScheduledsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scheduled = scheduleds(:one)
  end

  test "should get index" do
    get scheduleds_url
    assert_response :success
  end

  test "should get new" do
    get new_scheduled_url
    assert_response :success
  end

  test "should create scheduled" do
    assert_difference('Scheduled.count') do
      post scheduleds_url, params: { scheduled: { completed_on: @scheduled.completed_on, crop: @scheduled.crop, customer: @scheduled.customer, date: @scheduled.date, order: @scheduled.order, variety: @scheduled.variety, verb: @scheduled.verb } }
    end

    assert_redirected_to scheduled_url(Scheduled.last)
  end

  test "should show scheduled" do
    get scheduled_url(@scheduled)
    assert_response :success
  end

  test "should get edit" do
    get edit_scheduled_url(@scheduled)
    assert_response :success
  end

  test "should update scheduled" do
    patch scheduled_url(@scheduled), params: { scheduled: { completed_on: @scheduled.completed_on, crop: @scheduled.crop, customer: @scheduled.customer, date: @scheduled.date, order: @scheduled.order, variety: @scheduled.variety, verb: @scheduled.verb } }
    assert_redirected_to scheduled_url(@scheduled)
  end

  test "should destroy scheduled" do
    assert_difference('Scheduled.count', -1) do
      delete scheduled_url(@scheduled)
    end

    assert_redirected_to scheduleds_url
  end
end
