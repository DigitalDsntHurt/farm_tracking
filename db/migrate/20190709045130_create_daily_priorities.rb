class CreateDailyPriorities < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_priorities do |t|
      t.string :initial
      t.string :one
      t.boolean :oneexecuted
      t.string :two
      t.boolean :twoexecuted

      t.timestamps
    end
  end
end
