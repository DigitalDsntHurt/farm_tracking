class AddSoakStartDateToSeedTreatments < ActiveRecord::Migration[5.1]
  def change
  	add_column :seed_treatments, :soak_start_date, :date
  end
end
