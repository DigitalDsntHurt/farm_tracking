# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

=begin
else_count = 0
else_arr = []
SeedFlat.where(:harvest_weight_oz => nil).to_a.each{|seed_flat|
	if seed_flat.date_of_third_transplant != nil
		SeedFlatUpdate.create(seed_flat_id: seed_flat.id, update_type: "transplant", update_datetime: seed_flat.date_of_third_transplant, origin_system_id: 6, destination_system_id: 10, notes: "this seed flat update was created as part of a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2. this flat was never necessarily in Dumbo rack, but was moved to live storage on the correct date shown.")
		seed_flat.update(harvest_notes: "this flat was given a seed flat update which transplanted it from dumbo to live storage. this was done as part of a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2. this flat was never necessarily in Dumbo rack, but was moved to live storage on the correct date shown.")
	elsif seed_flat.date_of_second_transplant != nil 
		SeedFlatUpdate.create(seed_flat_id: seed_flat.id, update_type: "transplant", update_datetime: seed_flat.date_of_second_transplant, origin_system_id: 4, destination_system_id: 6, notes: "this seed flat update was created as part of a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2. this flat was never necessarily in Sue rack but was in Dumbo rack and was moved to Dumbo on the correct date shown.")
		seed_flat.update(harvest_notes: "this flat was given a seed flat update which transplanted it from sue shelf to dumbo. this was done as part of a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2. this flat was never necessarily in Sue rack but was in Dumbo rack and was moved to Dumbo on the correct date shown.")
	elsif seed_flat.date_of_first_transplant != nil
		SeedFlatUpdate.create(seed_flat_id: seed_flat.id, update_type: "transplant", update_datetime: seed_flat.date_of_first_transplant, origin_system_id: 2, destination_system_id: 4, notes: "this seed flat update was created as part of a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2. this flat was never necessarily in Sue rack but was first transplanted out of propagation on the correct date shown.")
		seed_flat.update(harvest_notes: "this flat was given a seed flat update which transplanted it from propagation shelf to sue shelf. this was done as part of a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2. this flat was never necessarily in Sue rack but was first transplanted out of propagation on the correct date shown.")
	elsif seed_flat.date_of_first_transplant == nil
		seed_flat.update(current_system_id: 2)
	else
		seed_flat.update(harvest_notes: "something weird happened to this flat during a data cleanse necessary to move from FarmTrackerv1 to FarmTrackerv2.")
		else_count += 1
		else_arr << seed_flat.id
	end
}

puts else_count
p else_arr
=end


=begin
results_arr = []

@harvested_flats = SeedFlat.where.not(harvest_weight_oz: 0.0).where.not(harvest_weight_oz: nil)
@crops = @harvested_flats.pluck(:crop).uniq

# get all crop names
@crops.reject{|crop| crop.include?(" (1/2)") }.sort.each{|crop|
	@hsh = {}
	# get all varieties of each crop
	SeedFlat.where(crop: crop).pluck(:crop_variety).uniq.each{|variety|
		@hsh[:crop] = crop
		@hsh[:variety] = variety

		#get avg seed treatment duration
		@treatment_durations_array = SeedTreatment.where(seed_crop: crop, seed_variety: variety).to_a
		unless @treatment_durations_array.length == 0
			#puts @treatment_durations_array.map{|treatment| (treatment.date_of_last_flat_sew  -  treatment.soak_start_datetime.to_date).to_i  }
			@treatment_durations_array.each{|item|
				#puts item.soak_start_datetime.to_date
				#puts item.date_of_last_flat_sew
				puts item if item.soak_start_datetime == nil or item.date_of_last_flat_sew == nil
				puts " " if item.soak_start_datetime == nil or item.date_of_last_flat_sew == nil
			}
			puts "==="		
		end
		
		

	}
	results_arr << @hsh
}

results_arr.each{|hsh|
#	p hsh
}
=end


=begin
@harvested_flats = SeedFlat.where.not(harvest_weight_oz: 0.0).where.not(harvest_weight_oz: nil)
@crops = @harvested_flats.pluck(:crop).uniq

# get all crop names
@crops.reject{|crop| crop.include?(" (1/2)") }.sort.each{|crop|
	puts crop
	#puts SeedFlat.where(crop: crop).pluck(:days_to_harvest_from_sew)
	puts "==="
}
=end

=begin
@harvested_flats = SeedFlat.where.not(harvest_weight_oz: 0.0).where.not(harvest_weight_oz: nil)
@crops = @harvested_flats.pluck(:crop).uniq.reject{|crop| crop.include?(" (1/2)") }.sort

# get all crop names
@crops.each{|crop| 
	puts crop
	@dths = []
	SeedFlat.where(crop: crop).each{|flat|
		next if flat.harvested_on == nil
		#@dths << (flat.harvested_on - flat.started_date).to_i		
		puts flat.former_flat_id
		puts flat.harvested_on
		puts flat.started_date
		puts (flat.harvested_on - flat.started_date).to_i
		puts

	}
	#puts @dths
	puts "==="
}

=end

=begin
## ##
## ## ## ## EXPORT ALL DATA TO CSV
## ##
require 'csv'
@export_document = CSV.open('export.csv','w+')
@headers = SeedFlat.column_names
@export_document << @headers

@all_flats = SeedFlat.all

@all_flats.each{|record|	
	@arr = []
	@headers.each{|header|
		@arr << record.send(header)
	}
	@export_document << @arr

	puts "*\n\n=== ===\n=== === ===\n=== ===\n\n*"
}

=end