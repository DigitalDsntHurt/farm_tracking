# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'csv'

=begin
=end

#=begin
#=end
##
## ## Seed Customers Table From Google Sheets CSV Export
##
seed_arr = []

csv = CSV.read(Rails.root.join('db','customers.csv'))
csv.to_a[0..-1].each{|row|
	@hsh = {}
	next if row[0] == nil
	@hsh[:name] = row[0].downcase
	seed_arr << @hsh
}

Customer.create(seed_arr)
#puts "Created #{seed_arr.count} new customers in Customers table!"




#=begin
#=end
##
## ## Update all Orders w/ customer_id
##
#Customer.create(name: "otd")
@customers = Customer.all.pluck(:name)
@orders = Order.all

#
## alter customer strings in Orders table to customer name strings in Customers table
#
@orders.each{|order|
	if order.customer.downcase == " " or order.customer.downcase == ""
		order.update(customer: nil)
	elsif order.customer.downcase == "alx"
		order.update(customer: "alx gastropub")
	elsif order.customer.downcase == "front porch"
		order.update(customer: "the front porch")		
	elsif order.customer.downcase == "local kitchen and wine merchants"
		order.update(customer: "local kitchen & wine merchant")
	elsif order.customer.downcase == "hotel san francisco"
		order.update(customer: "hotel san francisco")			
	else

	end
}

#
## update customer_id column in Orders table with new, corrected customer name string
#
@orders.each{|order|
	if @customers.include?(order.customer.downcase)
		order.update(customer_id: Customer.where(name: @customers[@customers.index(order.customer.downcase)])[0].id )
	else
		puts "#{order.customer.downcase} matches nothing"
	end
}



#=begin
#=end
##
## ## Update all SeedFlats w/ customer_id
##
#Customer.create(name: "black sands")
#Customer.create(name: "cassava")
@customers = Customer.all.pluck(:name)
@flats = SeedFlat.all

@flats.each{|flat|
	unless flat.sewn_for == nil
		if flat.sewn_for.downcase == " " or flat.sewn_for.downcase == ""
			flat.update(sewn_for: nil)
		elsif flat.sewn_for.downcase == "alx"
			flat.update(sewn_for: "alx gastropub")
		elsif flat.sewn_for.downcase == "front porch"
			flat.update(sewn_for: "the front porch")		
		elsif flat.sewn_for.downcase == "local kitchen and wine merchants"
			flat.update(sewn_for: "local kitchen & wine merchant")
		elsif flat.sewn_for.downcase == "liholiho"
			flat.update(sewn_for: "liholiho yacht club")	
		elsif flat.sewn_for.downcase == "lombardi's"
			flat.update(sewn_for: "overgrow")
		elsif flat.sewn_for.downcase == "hotel san francisco"
			flat.update(sewn_for: "hotel san francisco")					
		else

		end
	end
}

@flats.each{|flat|
	unless flat.sewn_for == nil
		if @customers.include?(flat.sewn_for.downcase)
			#puts "#{flat.sewn_for.downcase} matches #{@customers[@customers.index(flat.sewn_for.downcase)]}"
			flat.update(customer_id: Customer.where(name: @customers[@customers.index(flat.sewn_for.downcase)])[0].id )
		else
			puts "#{flat.sewn_for.downcase} matches nothing"
		end
	end
}




=begin
=end
##
## ## one-time seed to initiate FarmOpsDos
##

@today = Date.today
@orders = Order.where(cancelled_on: nil).sort_by(&:day_of_week)
@instructions = []

#
## seed soak and sew dos
#
@orders.each{|order|

	@crop = Crop.where(id: order.crop_id)[0]
	
	if @crop.ideal_treatment_days > 0 # crops for seed treatment
		@instruction = {}
		@instruction[:order_id] = order.id # set instruction order
		@instruction[:date] = OpsCal.set_ops_day_of_week(@crop,order) # sort out instruction date for next day of week
		@instruction[:verb] = "soak"
        @instruction[:crop_id] = @crop.id # set instruction crop
        @instruction[:qty] = OpsCal.soak_quantity(@crop,order) # set instruction qty (OUNCES)
        @instruction[:qty_units] = "oz" # set instruction qty_units

        @instructions << @instruction

	else # crops for dry seed sewing
		@instruction = {}
		@instruction[:order_id] = order.id # set instruction order		
		@instruction[:date] = OpsCal.set_ops_day_of_week(@crop,order) # sort out instruction date for next day of week
		@instruction[:verb] = "sew" # set instruction verb
		@instruction[:crop_id] = @crop.id # set instruction crop
		@instruction[:qty] = OpsCal.sew_quantity(@crop,order) # set instruction qty (FLATS)
		@instruction[:qty_units] = "flats" # set instruction qty_units
		
		@instructions << @instruction
	end
}

@sew = @instructions.select{|i| i[:verb] == "sew" } #.select{|i| i[:date].sunday? }
#@sunday_soak = OpsCal.aggreagte_soak_quantities(@instructions.select{|i| i[:verb] == "soak" }.select{|i| i[:date].sunday? })#
@tuesday_soak = OpsCal.aggreagte_soak_quantities(@instructions.select{|i| i[:verb] == "soak" }.select{|i| i[:date].tuesday? })
@thursday_soak = OpsCal.aggreagte_soak_quantities(@instructions.select{|i| i[:verb] == "soak" }.select{|i| i[:date].thursday? })

#@sunday_soak.each{|thing|
#	p thing
#	thing[:order_ids].each{|id|
#		puts "#{Crop.where(id: Order.where(id: id)[0].crop_id)[0].crop} for #{Customer.where(id: Order.where(id: id)[0].customer_id)[0].name}"
#	}
#	puts "==="
#}

FarmOpsDo.create(@sew)
#FarmOpsDo.create(@sunday_soak)
FarmOpsDo.create(@tuesday_soak)
FarmOpsDo.create(@thursday_soak)


=begin
#
## seed harvest dos
#
@harvest_instructions = []
@orders.each{|order|
	next if order.customer_id == 1
	@crop = Crop.where(id: order.crop_id)[0]
	@instruction = {}
	@instruction[:order_id] = order.id # set instruction order
	@instruction[:date] = OpsCal.date_of_next(order.day_of_week) #OpsCal.date_of_next(order.day_of_week) # sort out instruction date for next day of week
	@instruction[:verb] = "harvest"
    @instruction[:crop_id] = @crop.id # set instruction crop
    @instruction[:qty] = order.qty_oz # set instruction qty (OUNCES)
    @instruction[:qty_units] = "oz" # set instruction qty_units
    @harvest_instructions << @instruction
}

FarmOpsDo.create(@harvest_instructions)
=end










=begin
##
## ## set standing_order field on all Orders to true
##

Order.update_all(standing_order: true)
=end



=begin
##
## ## update crop_id on all Orders
##
@orders = Order.all
@orders.each{|order|
	@crop_id = Crop.where(crop: order.crop).where(crop_variety: order.variety)
	next if @crop_id.count == 0
	order.update(crop_id: @crop_id[0].id)
}
=end



=begin
##
## ## assign new crop ids to seed flats sewn with old crops data after massive crops seed fuckup
##
@old_crops = { 
	2 => ["arugula","eruca sativa"],
	3 => ["basil","dark opal"],
	4 => ["basil","genovese"],
	5 => ["beet","bull's blood"],
	6 => ["benitade","japanese waterpepper"],
	7 => ["broccoli","waltham"],
	8 => ["bunching onion","nebuka"],
	9 => ["cabbage","red acre"],
	10 => ["celery","light green"],
	11 => ["chervil","curled"],
	12 => ["chive","allium schoenoprasum"],
	13 => ["cilantro","coriander halves leisure"],
	14 => ["collard greens","georgia southern"],
	15 => ["corn","yellow popcorn"],
	16 => ["cress","curled"],
	17 => ["kale","red russian"],
	18 => ["kohlrabi","purple vienna"],
	19 => ["leek","american flag"],
	20 => ["mustard","mizuna red"],
	21 => ["mustard","wasabi"],
	23 => ["parsley","italian dark green"],
	24 => ["pea","dwarf grey sugar"],
	25 => ["radish","daikon"],
	26 => ["radish","purple sango"],
	27 => ["shiso","korean perilla"],
	28 => ["shiso","red perilla"],
	29 => ["shiso","ao green"],
	30 => ["sorrel","red veined"],
	31 => ["sunflower","black oil"],
	32 => ["swiss chard","ruby red"],
	33 => ["tarragon","russian"],
	1 => ["amaranth","red stripe leaf"],
	22 => ["nasturtium","jewel mix"],
	34 => ["celery","dark green"],
	35 => ["beet","detroit dark red"],
	36 => ["shiso","aka red perilla"]
}

@new_crops = {
	37 => ["amaranth","red stripe leaf"],
	38 => ["arugula","eruca sativa"],
	39 => ["basil","dark opal"],
	40 => ["basil","genovese"],
	41 => ["beet","detroit dark red"],
	42 => ["beet","bull's blood"],
	43 => ["benitade","japanese waterpepper"],
	44 => ["broccoli","waltham"],
	45 => ["bunching onion","nebuka"],
	46 => ["cabbage","red acre"],
	47 => ["celery","dark green"],
	48 => ["celery","light green"],
	49 => ["chervil","curled"],
	50 => ["chive","allium schoenoprasum"],
	51 => ["cilantro","coriander halves leisure"],
	52 => ["collard greens","georgia southern"],
	53 => ["corn","yellow popcorn"],
	54 => ["cress","curled"],
	55 => ["kale","red russian"],
	56 => ["kohlrabi","purple vienna"],
	57 => ["leek","american flag"],
	58 => ["mustard","mizuna"],
	59 => ["mustard","wasabi"],
	60 => ["nasturtium","jewel mix"],
	61 => ["parsley","italian dark green"],
	62 => ["pea","dwarf grey sugar"],
	63 => ["radish","daikon"],
	64 => ["radish","purple sango"],
	65 => ["shiso","aka red perilla"],
	66 => ["shiso","korean perilla"],
	67 => ["shiso","red perilla"],
	68 => ["shiso","ao green"],
	69 => ["sorrel","red veined"],
	70 => ["sunflower","black oil"],
	71 => ["swiss chard","ruby red"],
	72 => ["tarragon","russian"]
}

##
### FIX SeedFlats
##
#check # of problem flats
flats_with_crop_ids = SeedFlat.where.not(crop_id: nil)
problem_flats = []
flats_with_crop_ids.each{|flat|
	problem_flats << flat if Crop.where(id: flat.crop_id).count == 0
}
puts problem_flats.count

@pairs_of_ids = []
@old_crops.each{|k,v|
	@old_key = k
	@new_key = @new_crops.key(v)
	@pairs_of_ids << [@old_key,@new_key]
}

@pairs_of_ids.each{|pair|
	SeedFlat.where(crop_id: pair[0]).update_all(crop_id: pair[1])
}

#check # of problem flats
flats_with_crop_ids = SeedFlat.where.not(crop_id: nil)
problem_flats = []
flats_with_crop_ids.each{|flat|
	problem_flats << flat if Crop.where(id: flat.crop_id).count == 0
}
puts problem_flats.count

puts "\n\n***====***\n\n"
##
### FIX SeedTreatments
##
#check # of problem treatments
treatments_with_crop_ids = SeedTreatment.where.not(crop_id: nil)
problem_treatments = []
treatments_with_crop_ids.each{|treatment|
	problem_treatments << treatment if Crop.where(id: treatment.crop_id).count == 0
}
puts problem_treatments.count

@pairs_of_ids.each{|pair|
	SeedTreatment.where(crop_id: pair[0]).update_all(crop_id: pair[1])
}

#check # of problem treatments
treatments_with_crop_ids = SeedTreatment.where.not(crop_id: nil)
problem_treatments = []
treatments_with_crop_ids.each{|treatment|
	problem_treatments << treatment if Crop.where(id: treatment.crop_id).count == 0
}
puts problem_treatments.count
=end



=begin
##
## ## Seed Crops Table From Google Sheets CSV Export -- simple, most basic version for auto sew scheduling
##
seed_arr = []

csv = CSV.read(Rails.root.join('db','crops.csv'))
csv.to_a[1..-1].each{|row|
	@hsh = {}
	next if row[0] == nil
	@hsh[:crop] = row[0].downcase
	@hsh[:crop_variety] = row[1].downcase
	@hsh[:ideal_soak_seed_oz_per_flat] = row[2]
	@hsh[:ideal_treatment_days] = row[3]
	@hsh[:ideal_sew_seed_oz_per_flat] = row[4]
	@hsh[:ideal_propagation_days] = row[5]
	@hsh[:ideal_system_days] = row[6]
	@hsh[:ideal_post_treatment_dth] = row[7]
	@hsh[:ideal_total_dth] = row[8]
	@hsh[:ideal_yield_per_flat_oz] = row[9]
	@hsh[:sale_price_per_oz] = row[10].gsub("$","")
	@hsh[:sale_price_per_8oz] = row[11].gsub("$","")
	@hsh[:sale_price_per_16oz] = row[12].gsub("$","")
	@hsh[:sale_price_per_live_flat] = row[13].gsub("$","")
	seed_arr << @hsh
}

Crop.create(seed_arr)
puts "Created #{seed_arr.count} new crops in Crops table!"
=end


=begin
##
## ## Update crop_id on all active seed flats + all seed treatments
##

@db_crops = Crop.all
@live_seed_flats = SeedFlat.where(harvest_weight_oz: nil)
@live_seed_treatments = SeedTreatment.where.not(finished: true)
@seed_treatments = SeedTreatment.all


@live_seed_flats.each{|flat|
	@db_crop = Crop.where(crop: flat.crop).where(crop_variety: flat.crop_variety)
	flat.update(crop_id: @db_crop[0].id)
}


@live_seed_treatments.each{|treatment|
	@db_crop = Crop.where(crop: treatment.seed_crop).where(crop_variety: treatment.seed_variety)
	treatment.update(crop_id: @db_crop[0].id)
}


SeedFlat.where(crop: nil).delete_all
SeedTreatment.where(seed_crop: nil).delete_all

@seed_treatments.each{|treatment|
	if treatment.seed_crop == "chives"
		treatment.update(seed_crop: "chive", seed_variety: "allium schoenoprasum")
	elsif treatment.seed_crop == "nasturtium"
		treatment.update(seed_variety: "jewel mix")
	elsif treatment.seed_crop == "swiss chard" and treatment.seed_variety == "detroit dark red"
		treatment.update(seed_crop: "swiss chard", seed_variety: "ruby red")
	elsif treatment.seed_crop == "cilantro"
		treatment.update(seed_variety: "coriander halves leisure")
	elsif treatment.seed_crop == "benitade"	
		treatment.update(seed_variety: "japanese waterpepper")
	elsif treatment.seed_crop == "pea"	
		treatment.update(seed_variety: "dwarf grey sugar")
	elsif treatment.seed_crop == nil
		@seed_treatments.delete(treatment)
	else
		puts treatment
	end
}

@seed_treatments.each{|treatment|
	@db_crop = Crop.where(crop: treatment.seed_crop).where(crop_variety: treatment.seed_variety)
	treatment.update(crop_id: @db_crop[0].id) 
}
=end




=begin
##
## ## Seed Orders Table From Google Sheets CSV Export -- simple, most basic version for auto sew scheduling
##
seed_arr = []

csv = CSV.read(Rails.root.join('db','orders.csv'))
csv.to_a[1..-1].each{|row|
	@hsh = {}
	next if row[0] == nil
	@hsh[:customer] = row[0]
	@hsh[:day_of_week] = row[1]
	@hsh[:qty_oz] = row[2]
	@hsh[:crop] = row[3]
	@hsh[:variety] = row[4]
	seed_arr << @hsh
}

Order.create(seed_arr)
puts "Created #{seed_arr.count} new orders in Orders table!"

=end



=begin
##
## ## Seed Reservoirs Table From Google Sheets CSV Export
##
seed_arr = []

csv = CSV.read(Rails.root.join('db','rezs.csv'))
csv.to_a.each{|row|
	@hsh = {}
	@hsh[:name] = row[0].upcase
	@hsh[:size_liters] = row[1]
	@hsh[:brand] = row[2]
	seed_arr << @hsh
}

Reservoir.create(seed_arr)
puts seed_arr.count
=end



=begin
##
## ## Seed Nutrient Solutions Table From Google Sheets CSV Export
##
seed_arr = []

csv = CSV.read(Rails.root.join('db','nutsols.csv'))
csv.to_a[1..130].each{|row|
	@hsh = {}
	@hsh[:date_mixed] = Date.strptime(row[1],'%m/%d/%Y').to_date
	@hsh[:reservoir_id] = Reservoir.where(name: row[2].upcase)[0].id
	@hsh[:system] = row[6].upcase
	@hsh[:reservoir_fill_volume_liters] = row[8]
	@hsh[:topup_or_reset] = row[9]
	@hsh[:ingredient1] = row[10]
	@hsh[:ingredient1_qty_ml] = row[11]
	@hsh[:ingredient2] = row[12]
	@hsh[:ingredient2_qty_ml] = row[13]
	@hsh[:ingredient3] = row[14]
	@hsh[:ingredient3_qty_ml] = row[15]
	@hsh[:ingredient4] = row[16]
	@hsh[:ingredient4_qty_ml] = row[17]
	@hsh[:ingredient5] = row[18]
	@hsh[:ingredient5_qty_ml] = row[19]
	@hsh[:ingredient6] = row[20]
	@hsh[:ingredient6_qty_ml] = row[21]
	seed_arr << @hsh
}

NutrientSolution.create(seed_arr)
puts seed_arr.count
=end



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