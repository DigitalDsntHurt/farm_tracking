class ChangeForeignKeyNameForCurrentSystemOnSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	rename_column :seed_flats, :current_system, :current_system_id
  end
end
