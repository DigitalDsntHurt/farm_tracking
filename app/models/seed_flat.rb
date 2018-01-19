class SeedFlat < ApplicationRecord
	#after_validation :calculate_harvest_week #:convert_oz_to_lbs

	private

	#def convert_oz_to_lbs
	#	@ounces = self.harvest_weight_oz.to_f
	#	self.update!(:hrvst_wt_lbs => @ounces*0.0625)
	#end

	#def calculate_harvest_week
	#	#@week = self.harvested_on.cweek
	#	self.update!(:harvest_week => 99)
	#end
end
