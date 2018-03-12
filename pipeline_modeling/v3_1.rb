require 'csv'
require 'date'

filename = "mar_5"
filepath = "/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/sew_patterns/#{filename}.csv"

csv = CSV.read(filepath)
results = []

(Date.new(2018,2,25)..Date.new(2018,7,1)).each{ |check_date|
	@row = []
	@row << check_date
	@count = 0

	csv.reject{|row| row == [nil, nil, nil, nil] }[1..-1].each{ |flat|
		@first_transplant_year = flat[1].split("/")[-1].to_i
		@first_transplant_month = flat[1].split("/")[0].to_i
		@first_transplant_day = flat[1].split("/")[1].to_i
		@first_transplant_date = Date.new(@first_transplant_year,@first_transplant_month,@first_transplant_day)

		@harvest_year = flat[-1].split("/")[-1].to_i
		@harvest_month = flat[-1].split("/")[0].to_i
		@harvest_day = flat[-1].split("/")[1].to_i
		@harvest_date = Date.new(@harvest_year,@harvest_month,@harvest_day)

		@range = (@first_transplant_date..@harvest_date).to_a

		if @range.include?(check_date)
			@count += 1 
		end
	}

	@row << @count
	results << @row
}

newcsv = CSV.open("/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/sew_patterns/#{filename}--chart.csv","w+")
results.each{ |r|
	newcsv << r
}
