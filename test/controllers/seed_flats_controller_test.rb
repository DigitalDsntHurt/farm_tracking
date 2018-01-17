require 'test_helper'

class SeedFlatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seed_flat = seed_flats(:one)
  end

  test "should get index" do
    get seed_flats_url
    assert_response :success
  end

  test "should get new" do
    get new_seed_flat_url
    assert_response :success
  end

  test "should create seed_flat" do
    assert_difference('SeedFlat.count') do
      post seed_flats_url, params: { seed_flat: { crop: @seed_flat.crop, crop_variety: @seed_flat.crop_variety, date_of_first_transplant: @seed_flat.date_of_first_transplant, date_of_second_transplant: @seed_flat.date_of_second_transplant, emergence_notes: @seed_flat.emergence_notes, first_emerge_date: @seed_flat.first_emerge_date, first_transplant_notes: @seed_flat.first_transplant_notes, format: @seed_flat.format, full_emerge_date: @seed_flat.full_emerge_date, harvest_notes: @seed_flat.harvest_notes, harvest_week: @seed_flat.harvest_week, harvest_weight_oz: @seed_flat.harvest_weight_oz, harvested_on: @seed_flat.harvested_on, hrvst_wt_lbs: @seed_flat.hrvst_wt_lbs, medium: @seed_flat.medium, second_transplant_notes: @seed_flat.second_transplant_notes, seed_brand: @seed_flat.seed_brand, seed_media_treatment_notes: @seed_flat.seed_media_treatment_notes, seed_weight: @seed_flat.seed_weight, seed_wt_units: @seed_flat.seed_wt_units, started_date: @seed_flat.started_date } }
    end

    assert_redirected_to seed_flat_url(SeedFlat.last)
  end

  test "should show seed_flat" do
    get seed_flat_url(@seed_flat)
    assert_response :success
  end

  test "should get edit" do
    get edit_seed_flat_url(@seed_flat)
    assert_response :success
  end

  test "should update seed_flat" do
    patch seed_flat_url(@seed_flat), params: { seed_flat: { crop: @seed_flat.crop, crop_variety: @seed_flat.crop_variety, date_of_first_transplant: @seed_flat.date_of_first_transplant, date_of_second_transplant: @seed_flat.date_of_second_transplant, emergence_notes: @seed_flat.emergence_notes, first_emerge_date: @seed_flat.first_emerge_date, first_transplant_notes: @seed_flat.first_transplant_notes, format: @seed_flat.format, full_emerge_date: @seed_flat.full_emerge_date, harvest_notes: @seed_flat.harvest_notes, harvest_week: @seed_flat.harvest_week, harvest_weight_oz: @seed_flat.harvest_weight_oz, harvested_on: @seed_flat.harvested_on, hrvst_wt_lbs: @seed_flat.hrvst_wt_lbs, medium: @seed_flat.medium, second_transplant_notes: @seed_flat.second_transplant_notes, seed_brand: @seed_flat.seed_brand, seed_media_treatment_notes: @seed_flat.seed_media_treatment_notes, seed_weight: @seed_flat.seed_weight, seed_wt_units: @seed_flat.seed_wt_units, started_date: @seed_flat.started_date } }
    assert_redirected_to seed_flat_url(@seed_flat)
  end

  test "should destroy seed_flat" do
    assert_difference('SeedFlat.count', -1) do
      delete seed_flat_url(@seed_flat)
    end

    assert_redirected_to seed_flats_url
  end
end
