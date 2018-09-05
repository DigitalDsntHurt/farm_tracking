class AddDthToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_flats, :days_to_harvest_from_sew, :integer
  	add_column :seed_flats, :days_to_harvest_from_soak, :integer
  	add_column :seed_treatments, :finished, :boolean
  end
end
