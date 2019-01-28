require 'test_helper'

class NutrientSolutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nutrient_solution = nutrient_solutions(:one)
  end

  test "should get index" do
    get nutrient_solutions_url
    assert_response :success
  end

  test "should get new" do
    get new_nutrient_solution_url
    assert_response :success
  end

  test "should create nutrient_solution" do
    assert_difference('NutrientSolution.count') do
      post nutrient_solutions_url, params: { nutrient_solution: { date_mixed: @nutrient_solution.date_mixed, ingredient10: @nutrient_solution.ingredient10, ingredient10_qty_ml: @nutrient_solution.ingredient10_qty_ml, ingredient1: @nutrient_solution.ingredient1, ingredient1_qty_ml: @nutrient_solution.ingredient1_qty_ml, ingredient2: @nutrient_solution.ingredient2, ingredient2_qty_ml: @nutrient_solution.ingredient2_qty_ml, ingredient3: @nutrient_solution.ingredient3, ingredient3_qty_ml: @nutrient_solution.ingredient3_qty_ml, ingredient4: @nutrient_solution.ingredient4, ingredient4_qty_ml: @nutrient_solution.ingredient4_qty_ml, ingredient5: @nutrient_solution.ingredient5, ingredient5_qty_ml: @nutrient_solution.ingredient5_qty_ml, ingredient6: @nutrient_solution.ingredient6, ingredient6_qty_ml: @nutrient_solution.ingredient6_qty_ml, ingredient7: @nutrient_solution.ingredient7, ingredient7_qty_ml: @nutrient_solution.ingredient7_qty_ml, ingredient8: @nutrient_solution.ingredient8, ingredient8_qty_ml: @nutrient_solution.ingredient8_qty_ml, ingredient9: @nutrient_solution.ingredient9, ingredient9_qty_ml: @nutrient_solution.ingredient9_qty_ml, reservoir_fill_volume_liters: @nutrient_solution.reservoir_fill_volume_liters, reservoir_id: @nutrient_solution.reservoir_id, system: @nutrient_solution.system, topup_or_reset: @nutrient_solution.topup_or_reset } }
    end

    assert_redirected_to nutrient_solution_url(NutrientSolution.last)
  end

  test "should show nutrient_solution" do
    get nutrient_solution_url(@nutrient_solution)
    assert_response :success
  end

  test "should get edit" do
    get edit_nutrient_solution_url(@nutrient_solution)
    assert_response :success
  end

  test "should update nutrient_solution" do
    patch nutrient_solution_url(@nutrient_solution), params: { nutrient_solution: { date_mixed: @nutrient_solution.date_mixed, ingredient10: @nutrient_solution.ingredient10, ingredient10_qty_ml: @nutrient_solution.ingredient10_qty_ml, ingredient1: @nutrient_solution.ingredient1, ingredient1_qty_ml: @nutrient_solution.ingredient1_qty_ml, ingredient2: @nutrient_solution.ingredient2, ingredient2_qty_ml: @nutrient_solution.ingredient2_qty_ml, ingredient3: @nutrient_solution.ingredient3, ingredient3_qty_ml: @nutrient_solution.ingredient3_qty_ml, ingredient4: @nutrient_solution.ingredient4, ingredient4_qty_ml: @nutrient_solution.ingredient4_qty_ml, ingredient5: @nutrient_solution.ingredient5, ingredient5_qty_ml: @nutrient_solution.ingredient5_qty_ml, ingredient6: @nutrient_solution.ingredient6, ingredient6_qty_ml: @nutrient_solution.ingredient6_qty_ml, ingredient7: @nutrient_solution.ingredient7, ingredient7_qty_ml: @nutrient_solution.ingredient7_qty_ml, ingredient8: @nutrient_solution.ingredient8, ingredient8_qty_ml: @nutrient_solution.ingredient8_qty_ml, ingredient9: @nutrient_solution.ingredient9, ingredient9_qty_ml: @nutrient_solution.ingredient9_qty_ml, reservoir_fill_volume_liters: @nutrient_solution.reservoir_fill_volume_liters, reservoir_id: @nutrient_solution.reservoir_id, system: @nutrient_solution.system, topup_or_reset: @nutrient_solution.topup_or_reset } }
    assert_redirected_to nutrient_solution_url(@nutrient_solution)
  end

  test "should destroy nutrient_solution" do
    assert_difference('NutrientSolution.count', -1) do
      delete nutrient_solution_url(@nutrient_solution)
    end

    assert_redirected_to nutrient_solutions_url
  end
end
