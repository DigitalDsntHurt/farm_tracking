class AddDateOfThirdTransplantToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_flats, :date_of_third_transplant, :date
  end
end
