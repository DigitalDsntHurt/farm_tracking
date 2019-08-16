class AddIdealSoakDurationToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :ideal_soak_duration_hrs, :float
  end
end
