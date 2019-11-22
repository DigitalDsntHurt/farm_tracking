require 'test_helper'

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get 3_month" do
    get data_3_month_url
    assert_response :success
  end

end
