class Crop < ApplicationRecord

	before_save :set_ideal_total_dth

	private

	def set_ideal_total_dth
		self.ideal_total_dth = self.ideal_treatment_days + self.ideal_propagation_days + self.ideal_system_days
	end

end
