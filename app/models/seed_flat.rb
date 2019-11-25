class SeedFlat < ApplicationRecord
	
	# == Associations ============================================================
	has_many :seed_flat_updates
	has_one :system, foreign_key: 'current_system_id'
	belongs_to :crop

	# == Validations ============================================================
	validates_uniqueness_of :flat_id, if: -> { flat_id.present? }
	
	# == Data Queries ============================================================		
	def self.monthly_flats_sews_and_harvested
		@data = []

		@start = Date.parse("2018-11-01")
		@end = @start.next_month - 1

		until @start > Date.today
			@sewn = SeedFlat.where('started_date >= ? AND started_date <= ?', @start, @end).count
			@harvested = SeedFlat.where('harvested_on >= ? AND harvested_on <= ?', @start, @end).count
			@data << [@start.strftime("%b, %Y"),@sewn,@harvested]
			@start = @start.next_month
			@end = @start.next_month - 1
		end

		return @data
	end

	# == Flat Info Queries ============================================================		
	def self.transplants(flat)
		SeedFlatUpdate.where(seed_flat_id: flat.id).where(update_type: "transplant")
	end

	def self.first_transplant(flat)
		transplants(flat).order(updated_at: :asc).first
	end

	def self.harvests(flat)
		SeedFlatUpdate.where(seed_flat_id: flat.id).where(update_type: "harvest")
	end

	# == Record Calculations ============================================================
	def self.calculate_treatment_days(flat)
		if flat.seed_treatments_id == nil
			0
		else
			@treatment_start_date = SeedTreatment.where(id: flat.seed_treatments_id)[0].germination_start_date
			@sew_date = flat.started_date
			(@sew_date - @treatment_start_date).to_i
		end
	end

	def self.calculate_propagation_days(flat)
		@transplant_updates = transplants(flat)
		@sew_date = flat.started_date

		if @transplant_updates.count == 0
			(Date.today - @sew_date).to_i
		else
			@first_transplant_date = first_transplant(flat).updated_at.to_date
			(@first_transplant_date - @sew_date).to_i
		end
	end

	def self.calculate_system_days(flat)
		if transplants(flat).count == 0
			0
		elsif harvests(flat).count == 0 or flat.harvested_on == nil
			@first_transplant_date = first_transplant(flat).updated_at.to_date
			(Date.today - @first_transplant_date).to_i
		else
			@first_transplant_date = first_transplant(flat).updated_at.to_date
			(flat.harvested_on - @first_transplant_date).to_i
		end
	end

	def self.calculate_total_dth(flat)
		calculate_treatment_days(flat) + calculate_propagation_days(flat) + calculate_system_days(flat)
	end

	# == Callbacks ============================================================
	before_create :calculate_harvest_week, :convert_oz_to_lbs, :set_customer_id_if_blank, :set_anticipated_ready_date
	after_create :set_date_of_first_flat_sew_on_seed_treatment, :set_date_of_last_flat_sew_on_seed_treatment, :set_destination_flat_ids_on_seed_treatment, :set_anticipated_ready_date
	before_update  :move_flat_id_to_former_flat_id_on_harvest_or_kill, :kill_flat_id_on_harvest, :remove_current_system_id_on_harvest, :update_harvest_date_on_harvest, :calculate_harvest_week, :convert_oz_to_lbs, :set_days_to_harvest_from_sew, :set_days_to_harvest_from_soak, :set_anticipated_ready_date
	after_update :set_anticipated_ready_date
	before_validation :upcase_and_remove_whitespace_from_flat_id
	before_destroy :delete_seed_flat_updates

	#before_create :set_treatment_days, :set_propagation_days, :set_system_days, :set_total_dth

	private
=begin
=end
	# ==      ======================================

	def set_treatment_days
		self.treatment_days = SeedFlat.calculate_treatment_days(self)
	end

	def set_propagation_days
		self.propagation_days = SeedFlat.calculate_propagation_days(self)
	end

	def set_system_days
		self.system_days = SeedFlat.calculate_system_days(self)
	end

	def set_total_dth
		self.total_dth = SeedFlat.calculate_total_dth(self)
	end

	# ==      ======================================


	def remove_current_system_id_on_harvest
		unless harvest_weight_oz == nil
			self.current_system_id = nil
		end
	end

	def upcase_and_remove_whitespace_from_flat_id
		unless self.flat_id == nil
			self.flat_id = self.flat_id.gsub(" ","").upcase
		end
	end

	def set_customer_id_if_blank
		if self.customer_id == nil
			self.customer_id = Customer.where(name: "overgrow")[0].id
		end
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
		else 
			self.former_flat_id = self.flat_id
		end
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

	def set_days_to_harvest_from_sew
		unless self.harvested_on == nil
			self.days_to_harvest_from_sew = (self.harvested_on - self.started_date).to_i
		end
	end

	def set_days_to_harvest_from_soak
		unless self.harvested_on == nil or self.seed_treatments_id == nil
			@soak_start_date = SeedTreatment.where(id: self.seed_treatments_id)[0].soak_start_datetime.to_date
			self.days_to_harvest_from_soak = (self.harvested_on - @soak_start_date).to_i
		end
	end

	def set_anticipated_ready_date
		started = self.started_date
		propagation_days = Crop.where(id: self.crop_id)[0].ideal_propagation_days
		system_days = Crop.where(id: self.crop_id)[0].ideal_system_days
		dth_from_sew = propagation_days + system_days
		ready_date = started + dth_from_sew
		self.anticipated_ready_date = ready_date
	end

	def delete_seed_flat_updates
		SeedFlatUpdate.where(seed_flat_id: self.id).delete_all
	end
end