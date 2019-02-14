class AddRetiredToSystems < ActiveRecord::Migration[5.1]
  def change
  	add_column :systems, :retired, :boolean
  end
end
