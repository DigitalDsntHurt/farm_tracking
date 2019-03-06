class AddColsToFarmOpsDos < ActiveRecord::Migration[5.1]
  def change
    add_column :farm_ops_dos, :crop_id, :integer
    add_column :farm_ops_dos, :qty, :float
    add_column :farm_ops_dos, :qty_units, :string
  end
end
