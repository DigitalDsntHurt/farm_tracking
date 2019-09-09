class AddCurrentNutrientSolutionToSystems < ActiveRecord::Migration[5.1]
  def change
    add_column :systems, :current_nutrient_solution, :string
  end
end
