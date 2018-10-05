class SeedFlatUpdate < ApplicationRecord
  belongs_to :seed_flat

  after_create :set_seed_flat_current_system_id
  after_update :set_seed_flat_current_system_id

  private

  def set_seed_flat_current_system_id
  	unless self.destination_system_id == nil
	  	seed_flat = self.seed_flat
  		seed_flat.update(current_system_id: self.destination_system_id)
  	end
  end

end
