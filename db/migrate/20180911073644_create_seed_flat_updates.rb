class CreateSeedFlatUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :seed_flat_updates do |t|
      t.references :seed_flat, foreign_key: true
      t.string :update_type
      t.datetime :update_datetime
      t.integer :origin_system_id
      t.integer :destination_system_id
      t.text :notes

      t.timestamps
    end
    add_index :seed_flat_updates, :origin_system_id
    add_index :seed_flat_updates, :destination_system_id
  end
end
