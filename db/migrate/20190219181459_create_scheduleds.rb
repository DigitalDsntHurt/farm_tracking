class CreateScheduleds < ActiveRecord::Migration[5.1]
  def change
    create_table :scheduleds do |t|
      t.string :verb
      t.date :date
      t.string :crop
      t.string :variety
      t.string :customer
      t.string :order
      t.date :completed_on

      t.timestamps
    end
  end
end
