require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get harvest" do
    get lists_harvest_url
    assert_response :success
  end

end
