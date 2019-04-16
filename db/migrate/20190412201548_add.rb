class Add < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_treatments, :order_ids, :string, array: true, default: []
  end
end
