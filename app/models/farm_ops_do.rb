class FarmOpsDo < ApplicationRecord

	def self.monday_soak_records
		FarmOpsDo.where(verb: "soak").where(date: ThisWeekDates.monday)
	end

	def self.wednesday_soak_records
		FarmOpsDo.where(verb: "soak").where(date: ThisWeekDates.wednesday)
	end

	def self.friday_soak_records
		FarmOpsDo.where(verb: "soak").where(date: ThisWeekDates.friday)
	end


end
