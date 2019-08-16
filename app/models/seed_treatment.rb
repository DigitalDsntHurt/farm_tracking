class SeedTreatment < ApplicationRecord
	has_many :seed_flats
	
	before_create :calculate_planned_date_of_first_flat_sew, :convert_order_dummies_to_order_ids
	#after_create :create_rinse_farm_ops_do
	before_save :calculate_days_to_full_emergence, :set_soak_start_date
	#after_save :create_sew_farm_ops_do


	private

	def calculate_planned_date_of_first_flat_sew
		if self.seed_crop == "pea" or self.seed_crop == "sunflower"
			self.planned_date_of_first_flat_sew = self.soak_start_datetime.to_date + 3
		elsif self.seed_crop == "nasturtium"
			self.planned_date_of_first_flat_sew = self.soak_start_datetime.to_date + 5
		else
			self.planned_date_of_first_flat_sew = self.soak_start_datetime.to_date + 7
		end
	end

	def convert_order_dummies_to_order_ids
		unless self.order_dummies == nil
			self.order_dummies.split(",").each{|id|
				self.order_ids << id
			}
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

=begin
	def create_rinse_farm_ops_do
		@rinse_do = {}
		@rinse_do[:date] = (self.soak_start_datetime.to_time + 8.hours).to_datetime.to_date
		@rinse_do[:verb] = "rinse"
		@rinse_do[:crop_id] = self.crop_id
		@rinse_do[:treatment_id] = self.id 
		FarmOpsDo.create(@rinse_do)
	end

	def create_sew_farm_ops_do
		if germination_start_date_changed?
			@date = (self.germination_start_date + Crop.where(id: crop_id)[0].ideal_treatment_days)
			if self.order_ids.count == 0
				FarmOpsDo.create(verb: "sew soaked", crop_id: self.crop_id, date: @date, qty: (self.seed_quantity_oz / Crop.where(id: self.crop_id)[0].ideal_soak_seed_oz_per_flat).ceil, qty_units: "flats", treatment_id: self.id)
			else
				@sew_dos = []
				self.order_ids.each{|order_id|
					@sew_do = {}
					@sew_do[:date] = @date
					@sew_do[:verb] = "sew soaked"
					@sew_do[:crop_id] = self.crop_id
					@sew_do[:qty] = OpsCal.sew_quantity(Crop.where(id:self.crop_id)[0],Order.where(id:order_id)[0])
					@sew_do[:qty_units] = "flats"
					@sew_do[:treatment_id] = self.id
					@sew_do[:order_id] = order_id
					#@sew_do[:] 
					@sew_dos << @sew_do
				}
				FarmOpsDo.create(@sew_dos)
			end
		end
	end
=end
end