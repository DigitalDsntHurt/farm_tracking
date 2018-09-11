class CreateSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :systems do |t|
      t.references :room, foreign_key: true
      t.date :build_date
      t.string :system_type
      t.string :system_dimensions
      t.integer :levels
      t.text :lights
      t.text :notes

      t.timestamps
    end
  end
end
