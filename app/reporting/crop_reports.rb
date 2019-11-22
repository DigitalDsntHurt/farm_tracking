class CropReports
	def self.three_week_crop
	end

	def self.three_month

		@today = Date.today
		@three_months_ago = Date.today.last_month.last_month.last_month

		
		@crop_ids = Crop.all.pluck(:id)
		@crop_ids.each{|crop_id|
			@harvested_flats = Seed_Flat.where(crop_id: crop_id).where("harvested_on <= ? and harvested_on >= ?",@today,@three_months_ago )
			@yield_avg = @harvested_flats.pluck{|flat| flat.harvest_weight_oz }.inject{|oz,sum| oz + sum } / @harvested_flats.length
			@dth_avg = @harvested_flats.pluck{|flat| flat.harvest_weight_oz }.inject{|oz,sum| oz + sum } / @harvested_flats.length
		}

		
	end
end