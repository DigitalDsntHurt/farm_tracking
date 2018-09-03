require 'test_helper'

class SeedTreatmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seed_treatment = seed_treatments(:one)
  end

  test "should get index" do
    get seed_treatments_url
    assert_response :success
  end

  test "should get new" do
    get new_seed_treatment_url
    assert_response :success
  end

  test "should create seed_treatment" do
    assert_difference('SeedTreatment.count') do
      post seed_treatments_url, params: { seed_treatment: { date_of_first_flat_sew: @seed_treatment.date_of_first_flat_sew, date_of_last_flat_sew: @seed_treatment.date_of_last_flat_sew, days_to_full_emergence: @seed_treatment.days_to_full_emergence, destination_flat_ids: @seed_treatment.destination_flat_ids, emergence_notes: @seed_treatment.emergence_notes, first_emerge_date: @seed_treatment.first_emerge_date, full_emerge_date: @seed_treatment.full_emerge_date, germination_start_date: @seed_treatment.germination_start_date, germination_vehicle: @seed_treatment.germination_vehicle, has_many: @seed_treatment.has_many, killed_on: @seed_treatment.killed_on, planned_date_of_first_flat_sew: @seed_treatment.planned_date_of_first_flat_sew, post_soak_treatment: @seed_treatment.post_soak_treatment, seed_brand: @seed_treatment.seed_brand, seed_crop: @seed_treatment.seed_crop, seed_quantity_oz: @seed_treatment.seed_quantity_oz, seed_variety: @seed_treatment.seed_variety, soak_duration_hrs: @seed_treatment.soak_duration_hrs, soak_notes: @seed_treatment.soak_notes, soak_solution: @seed_treatment.soak_solution, soak_start_datetime: @seed_treatment.soak_start_datetime } }
    end

    assert_redirected_to seed_treatment_url(SeedTreatment.last)
  end

  test "should show seed_treatment" do
    get seed_treatment_url(@seed_treatment)
    assert_response :success
  end

  test "should get edit" do
    get edit_seed_treatment_url(@seed_treatment)
    assert_response :success
  end

  test "should update seed_treatment" do
    patch seed_treatment_url(@seed_treatment), params: { seed_treatment: { date_of_first_flat_sew: @seed_treatment.date_of_first_flat_sew, date_of_last_flat_sew: @seed_treatment.date_of_last_flat_sew, days_to_full_emergence: @seed_treatment.days_to_full_emergence, destination_flat_ids: @seed_treatment.destination_flat_ids, emergence_notes: @seed_treatment.emergence_notes, first_emerge_date: @seed_treatment.first_emerge_date, full_emerge_date: @seed_treatment.full_emerge_date, germination_start_date: @seed_treatment.germination_start_date, germination_vehicle: @seed_treatment.germination_vehicle, has_many: @seed_treatment.has_many, killed_on: @seed_treatment.killed_on, planned_date_of_first_flat_sew: @seed_treatment.planned_date_of_first_flat_sew, post_soak_treatment: @seed_treatment.post_soak_treatment, seed_brand: @seed_treatment.seed_brand, seed_crop: @seed_treatment.seed_crop, seed_quantity_oz: @seed_treatment.seed_quantity_oz, seed_variety: @seed_treatment.seed_variety, soak_duration_hrs: @seed_treatment.soak_duration_hrs, soak_notes: @seed_treatment.soak_notes, soak_solution: @seed_treatment.soak_solution, soak_start_datetime: @seed_treatment.soak_start_datetime } }
    assert_redirected_to seed_treatment_url(@seed_treatment)
  end

  test "should destroy seed_treatment" do
    assert_difference('SeedTreatment.count', -1) do
      delete seed_treatment_url(@seed_treatment)
    end

    assert_redirected_to seed_treatments_url
  end
end
