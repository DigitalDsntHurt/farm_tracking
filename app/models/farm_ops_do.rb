class FarmOpsDo < ApplicationRecord


	#
	## pull soak to-dos
	#

	def self.monday_soak_records
		FarmOpsDo.where(verb: "soak").where(date: ThisWeekDates.monday)
	end

	def self.wednesday_soak_records
		FarmOpsDo.where(verb: "soak").where(date: ThisWeekDates.wednesday)
	end

	def self.friday_soak_records
		FarmOpsDo.where(verb: "soak").where(date: ThisWeekDates.friday)
	end


	#
	## pull sew to-dos
	#

	def self.monday_sew_records
		FarmOpsDo.where(verb: "sew").where(date: ThisWeekDates.monday)
	end

	def self.wednesday_sew_records
		FarmOpsDo.where(verb: "sew").where(date: ThisWeekDates.wednesday)
	end

	def self.friday_sew_records
		FarmOpsDo.where(verb: "sew").where(date: ThisWeekDates.friday)
	end



end
