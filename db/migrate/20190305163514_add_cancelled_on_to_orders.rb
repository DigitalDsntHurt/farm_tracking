class AddCancelledOnToOrders < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :cancelled_on, :date
  end
end
