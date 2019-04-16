class AddOrderIdToFarmOpsDo < ActiveRecord::Migration[5.1]
  def change
    add_column :farm_ops_dos, :order_id, :integer
  end
end
