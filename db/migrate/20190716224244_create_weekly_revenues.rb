class CreateWeeklyRevenues < ActiveRecord::Migration[5.1]
  def change
    create_table :weekly_revenues do |t|
      t.date :week_start_date
      t.float :revenue

      t.timestamps
    end
  end
end
