class Crop < ApplicationRecord

	before_save :set_ideal_total_dth, :capitalization_standards

	private

	def set_ideal_total_dth
		self.ideal_total_dth = self.ideal_treatment_days + self.ideal_propagation_days + self.ideal_system_days
	end

	def capitalization_standards
		self.crop = self.crop.capitalize
		self.crop_variety = self.crop_variety.downcase
	end

end
