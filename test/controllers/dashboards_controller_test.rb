require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get calendar" do
    get dashboards_calendar_url
    assert_response :success
  end

  test "should get pipeline" do
    get dashboards_pipeline_url
    assert_response :success
  end

  test "should get calculator" do
    get dashboards_calculator_url
    assert_response :success
  end

end
