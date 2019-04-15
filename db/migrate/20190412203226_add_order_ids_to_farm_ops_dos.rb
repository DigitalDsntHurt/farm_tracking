class AddOrderIdsToFarmOpsDos < ActiveRecord::Migration[5.1]
  def change
  	add_column :farm_ops_dos, :order_ids, :string, array: true, default: []
  end
end
