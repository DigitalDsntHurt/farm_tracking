class AddCompletedOnToFarmOpsDos < ActiveRecord::Migration[5.1]
  def change
  	add_column :farm_ops_dos, :completed_on, :date
  end
end
