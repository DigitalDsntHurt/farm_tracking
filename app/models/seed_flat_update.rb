class SeedFlatUpdate < ApplicationRecord
  belongs_to :seed_flat

  after_create :set_seed_flat_current_system
  after_update :set_seed_flat_current_system

  private

  def set_seed_flat_current_system
  end
  
end
