class AddTreatmentDaysAndPropagationDaysToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :treatment_days, :integer
    add_column :seed_flats, :propagation_days, :integer
  end
end
