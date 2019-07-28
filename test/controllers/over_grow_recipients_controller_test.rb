require 'test_helper'

class OverGrowRecipientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @over_grow_recipient = over_grow_recipients(:one)
  end

  test "should get index" do
    get over_grow_recipients_url
    assert_response :success
  end

  test "should get new" do
    get new_over_grow_recipient_url
    assert_response :success
  end

  test "should create over_grow_recipient" do
    assert_difference('OverGrowRecipient.count') do
      post over_grow_recipients_url, params: { over_grow_recipient: { email: @over_grow_recipient.email } }
    end

    assert_redirected_to over_grow_recipient_url(OverGrowRecipient.last)
  end

  test "should show over_grow_recipient" do
    get over_grow_recipient_url(@over_grow_recipient)
    assert_response :success
  end

  test "should get edit" do
    get edit_over_grow_recipient_url(@over_grow_recipient)
    assert_response :success
  end

  test "should update over_grow_recipient" do
    patch over_grow_recipient_url(@over_grow_recipient), params: { over_grow_recipient: { email: @over_grow_recipient.email } }
    assert_redirected_to over_grow_recipient_url(@over_grow_recipient)
  end

  test "should destroy over_grow_recipient" do
    assert_difference('OverGrowRecipient.count', -1) do
      delete over_grow_recipient_url(@over_grow_recipient)
    end

    assert_redirected_to over_grow_recipients_url
  end
end
