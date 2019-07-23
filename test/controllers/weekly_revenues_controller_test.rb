require 'test_helper'

class WeeklyRevenuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weekly_revenue = weekly_revenues(:one)
  end

  test "should get index" do
    get weekly_revenues_url
    assert_response :success
  end

  test "should get new" do
    get new_weekly_revenue_url
    assert_response :success
  end

  test "should create weekly_revenue" do
    assert_difference('WeeklyRevenue.count') do
      post weekly_revenues_url, params: { weekly_revenue: { revenue: @weekly_revenue.revenue, week_start_date: @weekly_revenue.week_start_date } }
    end

    assert_redirected_to weekly_revenue_url(WeeklyRevenue.last)
  end

  test "should show weekly_revenue" do
    get weekly_revenue_url(@weekly_revenue)
    assert_response :success
  end

  test "should get edit" do
    get edit_weekly_revenue_url(@weekly_revenue)
    assert_response :success
  end

  test "should update weekly_revenue" do
    patch weekly_revenue_url(@weekly_revenue), params: { weekly_revenue: { revenue: @weekly_revenue.revenue, week_start_date: @weekly_revenue.week_start_date } }
    assert_redirected_to weekly_revenue_url(@weekly_revenue)
  end

  test "should destroy weekly_revenue" do
    assert_difference('WeeklyRevenue.count', -1) do
      delete weekly_revenue_url(@weekly_revenue)
    end

    assert_redirected_to weekly_revenues_url
  end
end
