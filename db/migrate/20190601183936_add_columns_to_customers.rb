class AddColumnsToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :harvest_preferences, :text
    add_column :customers, :delivery_preferences, :text
    add_column :customers, :notes, :text
  end
end
