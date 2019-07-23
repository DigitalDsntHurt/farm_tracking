class AddStartDateToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :start_date, :date
  end
end
