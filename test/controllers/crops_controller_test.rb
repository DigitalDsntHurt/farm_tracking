require 'test_helper'

class CropsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crop = crops(:one)
  end

  test "should get index" do
    get crops_url
    assert_response :success
  end

  test "should get new" do
    get new_crop_url
    assert_response :success
  end

  test "should create crop" do
    assert_difference('Crop.count') do
      post crops_url, params: { crop: { avg_6month_days_to_harvest: @crop.avg_6month_days_to_harvest, avg_6month_seed_oz_per_flat: @crop.avg_6month_seed_oz_per_flat, avg_6month_yield_per_flat_oz: @crop.avg_6month_yield_per_flat_oz, avg_6week_days_to_harvest: @crop.avg_6week_days_to_harvest, avg_6week_seed_oz_per_flat: @crop.avg_6week_seed_oz_per_flat, avg_6week_yield_per_flat_oz: @crop.avg_6week_yield_per_flat_oz, avg_alltime_days_to_harvest: @crop.avg_alltime_days_to_harvest, avg_alltime_seed_oz_per_flat: @crop.avg_alltime_seed_oz_per_flat, avg_alltime_yield_per_flat_oz: @crop.avg_alltime_yield_per_flat_oz, avg_days_to_first_transplant: @crop.avg_days_to_first_transplant, avg_seed_treatment_duration_days: @crop.avg_seed_treatment_duration_days, calculated_seed_oz_to_soak_per_desired_flat: @crop.calculated_seed_oz_to_soak_per_desired_flat, crop: @crop.crop, crop_variety: @crop.crop_variety, ideal_days_to_first_transplant: @crop.ideal_days_to_first_transplant, ideal_days_to_harvest: @crop.ideal_days_to_harvest, ideal_seed_oz_per_flat: @crop.ideal_seed_oz_per_flat, ideal_seed_oz_to_soak_per_desired_flat: @crop.ideal_seed_oz_to_soak_per_desired_flat, ideal_seed_treatment_duration_days: @crop.ideal_seed_treatment_duration_days, sale_price_per_16oz: @crop.sale_price_per_16oz, sale_price_per_8oz: @crop.sale_price_per_8oz, sale_price_per_live_flat: @crop.sale_price_per_live_flat, sale_price_per_oz: @crop.sale_price_per_oz, seed_treatment: @crop.seed_treatment } }
    end

    assert_redirected_to crop_url(Crop.last)
  end

  test "should show crop" do
    get crop_url(@crop)
    assert_response :success
  end

  test "should get edit" do
    get edit_crop_url(@crop)
    assert_response :success
  end

  test "should update crop" do
    patch crop_url(@crop), params: { crop: { avg_6month_days_to_harvest: @crop.avg_6month_days_to_harvest, avg_6month_seed_oz_per_flat: @crop.avg_6month_seed_oz_per_flat, avg_6month_yield_per_flat_oz: @crop.avg_6month_yield_per_flat_oz, avg_6week_days_to_harvest: @crop.avg_6week_days_to_harvest, avg_6week_seed_oz_per_flat: @crop.avg_6week_seed_oz_per_flat, avg_6week_yield_per_flat_oz: @crop.avg_6week_yield_per_flat_oz, avg_alltime_days_to_harvest: @crop.avg_alltime_days_to_harvest, avg_alltime_seed_oz_per_flat: @crop.avg_alltime_seed_oz_per_flat, avg_alltime_yield_per_flat_oz: @crop.avg_alltime_yield_per_flat_oz, avg_days_to_first_transplant: @crop.avg_days_to_first_transplant, avg_seed_treatment_duration_days: @crop.avg_seed_treatment_duration_days, calculated_seed_oz_to_soak_per_desired_flat: @crop.calculated_seed_oz_to_soak_per_desired_flat, crop: @crop.crop, crop_variety: @crop.crop_variety, ideal_days_to_first_transplant: @crop.ideal_days_to_first_transplant, ideal_days_to_harvest: @crop.ideal_days_to_harvest, ideal_seed_oz_per_flat: @crop.ideal_seed_oz_per_flat, ideal_seed_oz_to_soak_per_desired_flat: @crop.ideal_seed_oz_to_soak_per_desired_flat, ideal_seed_treatment_duration_days: @crop.ideal_seed_treatment_duration_days, sale_price_per_16oz: @crop.sale_price_per_16oz, sale_price_per_8oz: @crop.sale_price_per_8oz, sale_price_per_live_flat: @crop.sale_price_per_live_flat, sale_price_per_oz: @crop.sale_price_per_oz, seed_treatment: @crop.seed_treatment } }
    assert_redirected_to crop_url(@crop)
  end

  test "should destroy crop" do
    assert_difference('Crop.count', -1) do
      delete crop_url(@crop)
    end

    assert_redirected_to crops_url
  end
end
