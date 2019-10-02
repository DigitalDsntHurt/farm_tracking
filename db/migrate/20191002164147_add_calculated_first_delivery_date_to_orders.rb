class AddCalculatedFirstDeliveryDateToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :calculated_first_delivery_date, :date
  end
end
