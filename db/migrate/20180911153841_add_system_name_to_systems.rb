class AddSystemNameToSystems < ActiveRecord::Migration[5.1]
  def change
  	add_column :systems, :system_name, :string
  end
end
