class System < ApplicationRecord
  belongs_to :room

  before_save :set_retired
  
	#
	## Data / Queries
	#
	def self.fitz_active_systems
    	System.where(room_id: 2).where(retired_on: nil).order(:flat_slots)
	end

	def self.fitz_propagation
		System.where(system_name: "1. Propagation")
	end

	def self.fitz_flats_in_systems
		@target = []
		self.fitz_active_systems.each{|system|
			@hsh = {}
			@hsh[:system] = system
			@hsh[:flats] = SeedFlat.where(current_system_id: system.id).where(harvested_on: nil)
			@target << @hsh
		}
		@target
	end


  private

  def set_retired
  	self.retired = true if self.retired_on != nil
  end
end
