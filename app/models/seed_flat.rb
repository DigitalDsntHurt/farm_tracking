class SeedFlat < ApplicationRecord
	before_create :calculate_harvest_week, :convert_oz_to_lbs
	after_create :set_date_of_first_flat_sew_on_seed_treatment, :set_date_of_last_flat_sew_on_seed_treatment, :set_destination_flat_ids_on_seed_treatment, :create_seed_flat_update
	before_update :move_flat_id_to_former_flat_id_on_harvest_or_kill, :kill_flat_id_on_harvest, :update_harvest_date_on_harvest, :calculate_harvest_week, :convert_oz_to_lbs
	#after_update :move_flat_id_to_harvest_notes_on_harvest
	validates_uniqueness_of :flat_id

	private

	def create_seed_flat_update
		@propagation_rack = Room.where(id: self.room_id)[0].systems.where(system_name: "propagation")[0].id
		SeedFlatUpdate.create(seed_flat_id: self.id, update_type: "sew", update_datetime: Time.now, destination_system_id: @propagation_rack)
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

	def set_date_of_first_flat_sew_on_seed_treatment
		unless self.seed_treatments_id == nil
			@seed_treatment = SeedTreatment.where(id: self.seed_treatments_id)
			@doffs = SeedFlat.where(seed_treatments_id: @seed_treatment[0].id).order(:started_date).first.started_date
			@seed_treatment.update(date_of_first_flat_sew: @doffs)
		end
	end

	def set_date_of_last_flat_sew_on_seed_treatment
		unless self.seed_treatments_id == nil
			@seed_treatment = SeedTreatment.where(id: self.seed_treatments_id)
			@dolfs = SeedFlat.where(seed_treatments_id: @seed_treatment[0].id).order(:started_date).last.started_date
			@seed_treatment.update(date_of_last_flat_sew: @dolfs)
		end
	end

	def set_destination_flat_ids_on_seed_treatment
		unless self.seed_treatments_id == nil
			@seed_treatment = SeedTreatment.where(id: self.seed_treatments_id)
			@flat_ids = []
			SeedFlat.where(seed_treatments_id: @seed_treatment[0].id).each{|flat|
				@flat_ids << flat.id
			}
			@seed_treatment.update(destination_flat_ids: @flat_ids )
		end
	end
	
end