class AddRetiredOnToSystems < ActiveRecord::Migration[5.1]
  def change
    add_column :systems, :retired_on, :date
  end
end
