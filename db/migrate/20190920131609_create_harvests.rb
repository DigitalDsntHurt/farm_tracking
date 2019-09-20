class CreateHarvests < ActiveRecord::Migration[5.1]
  def change
    create_table :harvests do |t|
      t.integer :customer_id
      t.integer :crop_id
      t.integer :order_id
      t.float :qty_oz
      t.string :instructions
      t.date :date
      t.datetime :time
      t.boolean :completed

      t.timestamps
    end
  end
end
