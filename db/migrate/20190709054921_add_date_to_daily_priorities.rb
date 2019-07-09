class AddDateToDailyPriorities < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_priorities, :date, :date
  end
end
