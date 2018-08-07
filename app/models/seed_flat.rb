class SeedFlat < ApplicationRecord
	before_create :calculate_harvest_week, :convert_oz_to_lbs, :downcase
	before_update :move_flat_id_to_former_flat_id_on_harvest_or_kill, :kill_flat_id_on_harvest, :update_harvest_date_on_harvest, :calculate_harvest_week, :convert_oz_to_lbs
	#after_update :move_flat_id_to_harvest_notes_on_harvest
	validates_uniqueness_of :flat_id

	private

	def downcase
		self.crop = self.crop.downcase
		self.crop_variety = self.crop_variety.downcase
		self.seed_brand = self.seed_brand.downcase
		self.seed_media_treatment_notes = self.seed_media_treatment_notes.downcase
	end

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

	def move_flat_id_to_former_flat_id_on_harvest_or_kill
		if self.harvest_weight_oz == nil
			#
		#elsif self.harvest_weight_oz == 0.0  
			#
		else 
			self.former_flat_id = self.flat_id
		end
		#unless self.harvest_weight_oz == nil #or self.harvest_weight_oz == 0.0
		#	self.harvest_notes = self.harvest_notes.prepend("formerly flat # #{self.flat_id} | ")
		#end
	end

	def kill_flat_id_on_harvest
		unless self.harvest_weight_oz == nil
			self.flat_id = nil
		end
	end

	def update_harvest_date_on_harvest
		if self.harvest_weight_oz != nil
			self.harvested_on = Date.today
		end
	end
	
end