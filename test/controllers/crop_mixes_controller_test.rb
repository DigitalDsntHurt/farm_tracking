require 'test_helper'

class CropMixesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crop_mix = crop_mixes(:one)
  end

  test "should get index" do
    get crop_mixes_url
    assert_response :success
  end

  test "should get new" do
    get new_crop_mix_url
    assert_response :success
  end

  test "should create crop_mix" do
    assert_difference('CropMix.count') do
      post crop_mixes_url, params: { crop_mix: { crop_eight_id: @crop_mix.crop_eight_id, crop_eight_parts: @crop_mix.crop_eight_parts, crop_five_id: @crop_mix.crop_five_id, crop_five_parts: @crop_mix.crop_five_parts, crop_four_id: @crop_mix.crop_four_id, crop_four_parts: @crop_mix.crop_four_parts, crop_one_id: @crop_mix.crop_one_id, crop_one_parts: @crop_mix.crop_one_parts, crop_seven_id: @crop_mix.crop_seven_id, crop_seven_parts: @crop_mix.crop_seven_parts, crop_six_id: @crop_mix.crop_six_id, crop_six_parts: @crop_mix.crop_six_parts, crop_three_id: @crop_mix.crop_three_id, crop_three_parts: @crop_mix.crop_three_parts, crop_two_id: @crop_mix.crop_two_id, crop_two_parts: @crop_mix.crop_two_parts, name: @crop_mix.name } }
    end

    assert_redirected_to crop_mix_url(CropMix.last)
  end

  test "should show crop_mix" do
    get crop_mix_url(@crop_mix)
    assert_response :success
  end

  test "should get edit" do
    get edit_crop_mix_url(@crop_mix)
    assert_response :success
  end

  test "should update crop_mix" do
    patch crop_mix_url(@crop_mix), params: { crop_mix: { crop_eight_id: @crop_mix.crop_eight_id, crop_eight_parts: @crop_mix.crop_eight_parts, crop_five_id: @crop_mix.crop_five_id, crop_five_parts: @crop_mix.crop_five_parts, crop_four_id: @crop_mix.crop_four_id, crop_four_parts: @crop_mix.crop_four_parts, crop_one_id: @crop_mix.crop_one_id, crop_one_parts: @crop_mix.crop_one_parts, crop_seven_id: @crop_mix.crop_seven_id, crop_seven_parts: @crop_mix.crop_seven_parts, crop_six_id: @crop_mix.crop_six_id, crop_six_parts: @crop_mix.crop_six_parts, crop_three_id: @crop_mix.crop_three_id, crop_three_parts: @crop_mix.crop_three_parts, crop_two_id: @crop_mix.crop_two_id, crop_two_parts: @crop_mix.crop_two_parts, name: @crop_mix.name } }
    assert_redirected_to crop_mix_url(@crop_mix)
  end

  test "should destroy crop_mix" do
    assert_difference('CropMix.count', -1) do
      delete crop_mix_url(@crop_mix)
    end

    assert_redirected_to crop_mixes_url
  end
end
