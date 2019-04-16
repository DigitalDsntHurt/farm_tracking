class AddTreatmentIdToFarmOpsDos < ActiveRecord::Migration[5.1]
  def change
    add_column :farm_ops_dos, :treatment_id, :integer
  end
end
