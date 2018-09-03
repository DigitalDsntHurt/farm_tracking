class AddSeedTreatmentsRefToSeedFlats < ActiveRecord::Migration[5.1]
  def change
  	add_reference :seed_flats, :seed_treatments, foreign_key: true
  end
end
