require 'csv'
require 'date'

csv = CSV.read("/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/4flats_everyotherday.csv")

start_date = Date.today
target = []
40.times do |num|
	@targ = []
	start_date += num
	@targ << start_date
	p start_date
	@count = 0
	csv[1..-1].each{|flat|
		next if flat == [nil, nil, nil, nil]
		@sew_year = flat[0].split("/")[-1].to_i
		@sew_month = flat[0].split("/")[0].to_i
		@sew_day = flat[0].split("/")[1].to_i
		@sew_date = Date.new(@sew_year,@sew_month,@sew_day)

		@harvest_year = flat[3].split("/")[-1].to_i
		@harvest_month = flat[3].split("/")[0].to_i
		@harvest_day = flat[3].split("/")[1].to_i
		@harvest_date = Date.new(@harvest_year,@harvest_month,@harvest_day)

 		if start_date >= @sew_date and start_date <= @harvest_date
			@count += 1
			puts "#{start_date} is between #{@sew_date} & #{@harvest_date}"
			#p start_date.class
			#p Date.parse(flat[0])#.to_date
			puts 
		end
	}
	@targ << @count
	target << @targ
end

target.each{|thing|
	p thing
}