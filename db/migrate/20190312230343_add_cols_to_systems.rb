class AddColsToSystems < ActiveRecord::Migration[5.1]
  def change
    add_column :systems, :pumps, :string
    add_column :systems, :pump_time, :string
  end
end
