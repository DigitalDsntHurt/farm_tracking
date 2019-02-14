class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :customer
      t.string :day_of_week
      t.date :date
      t.integer :qty_oz
      t.string :crop
      t.string :variety

      t.timestamps
    end
  end
end
