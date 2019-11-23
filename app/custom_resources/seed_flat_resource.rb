class SeedFlatResource

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

end