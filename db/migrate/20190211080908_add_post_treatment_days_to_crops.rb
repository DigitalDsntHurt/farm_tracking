class AddPostTreatmentDaysToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :ideal_post_treatment_dth, :float
    add_column :crops, :avg_post_treatment_dth, :float
    add_column :crops, :ideal_total_dth, :float
    add_column :crops, :avg_total_dth, :float
  end
end
