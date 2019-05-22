require 'test_helper'

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get Ops" do
    get calendars_Ops_url
    assert_response :success
  end

end
