class SeedTreatment < ApplicationRecord
	has_many :seed_flats
	
	before_create :calculate_planned_date_of_first_flat_sew
	after_create :create_rinse_farm_ops_do
	before_save :calculate_days_to_full_emergence, :set_soak_start_date #, :remove_white_spaces_from_crop_names #, :downcase_all


	private

#	def downcase_all
#		self.
#	end

	def calculate_planned_date_of_first_flat_sew
		if self.seed_crop == "pea" or self.seed_crop == "sunflower"
			self.planned_date_of_first_flat_sew = self.soak_start_datetime.to_date + 3
		elsif self.seed_crop == "nasturtium"
			self.planned_date_of_first_flat_sew = self.soak_start_datetime.to_date + 5
		else
			self.planned_date_of_first_flat_sew = self.soak_start_datetime.to_date + 7
		end
	end

	def calculate_days_to_full_emergence
		unless self.full_emerge_date == nil
			@dtfe = (self.full_emerge_date - self.soak_start_datetime.to_date).to_i
			self.days_to_full_emergence = @dtfe
		end
	end

	def set_soak_start_date
		self.soak_start_date = self.soak_start_datetime.to_date
	end

	def create_rinse_farm_ops_do
		@rinse_do = {}
		@rinse_do[:date] = (self.soak_start_datetime.to_time + 8.hours).to_datetime.to_date
		@rinse_do[:verb] = "rinse"
		@rinse_do[:crop_id] = self.crop_id
		@rinse_do[:treatment_id] = self.id 
		FarmOpsDo.create(@rinse_do)
	end

end