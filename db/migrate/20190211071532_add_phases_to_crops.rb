class AddPhasesToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :ideal_treatment_days, :float
    add_column :crops, :avg_treatment_days, :float
    add_column :crops, :ideal_propagation_days, :float
    add_column :crops, :avg_propagation_days, :float
    add_column :crops, :ideal_system_days, :float
    add_column :crops, :avg_system_days, :float
  end
end
