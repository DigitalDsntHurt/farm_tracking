class AddStandingOrderToOrders < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :standing_order, :boolean
  end
end
