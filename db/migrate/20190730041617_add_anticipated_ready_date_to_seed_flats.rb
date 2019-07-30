class AddAnticipatedReadyDateToSeedFlats < ActiveRecord::Migration[5.1]
  def change
    add_column :seed_flats, :anticipated_ready_date, :date
  end
end
