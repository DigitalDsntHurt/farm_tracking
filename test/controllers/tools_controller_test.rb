require 'test_helper'

class ToolsControllerTest < ActionDispatch::IntegrationTest
  test "should get crop_availability" do
    get tools_crop_availability_url
    assert_response :success
  end

end
