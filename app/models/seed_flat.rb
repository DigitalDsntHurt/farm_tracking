class SeedFlat < ApplicationRecord
	before_create :calculate_harvest_week, :convert_oz_to_lbs
	before_update :calculate_harvest_week, :convert_oz_to_lbs, :kill_flat_id_on_harvest
	validates_uniqueness_of :flat_id

	private

	def convert_oz_to_lbs
		unless self.harvest_weight_oz == nil
			self.hrvst_wt_lbs = self.harvest_weight_oz * 0.0625
		end
	end

	def calculate_harvest_week
		unless self.harvested_on == nil
			self.harvest_week = self.harvested_on.cweek
		end
	end

	def kill_flat_id_on_harvest
		unless self.harvested_on == nil
			self.flat_id = nil
		end
	end
	
end