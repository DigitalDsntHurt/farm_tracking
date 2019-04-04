class ChangeOrdersQtyOzToDecimal < ActiveRecord::Migration[5.1]
  def change
  	change_column :orders, :qty_oz, :float
  end
end
