class AddColumnsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :maturity_days, :integer
    add_column :orders, :harvest_preferences, :text
  end
end
