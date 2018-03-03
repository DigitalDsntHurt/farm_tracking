require 'csv'
require 'date'

#csv = CSV.read("/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/4flats_everyotherday.csv")
#csv = CSV.read("/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/4flats_mon&thu.csv")
#csv = CSV.read("/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/4flats_mon_wed_fri.csv")

dir = "/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/sew_patterns/"

Dir.foreach(dir) do |file_name|
	next if file_name == '.' or file_name == '..' or file_name == "Icon\r"

	csv = CSV.read(dir+file_name)
	results = []

	(Date.new(2018,2,25)..Date.new(2018,5,1)).each{ |check_date|
		@row = []
		@row << check_date
		@count = 0

		csv.reject{|row| row == [nil, nil, nil, nil] }[1..-1].each{|flat|
			@sew_year = flat[0].split("/")[-1].to_i
			@sew_month = flat[0].split("/")[0].to_i
			@sew_day = flat[0].split("/")[1].to_i
			@sew_date = Date.new(@sew_year,@sew_month,@sew_day)

			@harvest_year = flat[-1].split("/")[-1].to_i
			@harvest_month = flat[-1].split("/")[0].to_i
			@harvest_day = flat[-1].split("/")[1].to_i
			@harvest_date = Date.new(@harvest_year,@harvest_month,@harvest_day)

			@range = (@sew_date..@harvest_date).to_a

			if @range.include?(check_date)
				@count += 1 
			end
		}

		@row << @count
		results << @row
	}

	newcsv = CSV.open("/Users/noon/Google\ Drive/CODE/Ruby/WORKING/farm_tracking/pipeline_modeling/sew_patterns/#{file_name}--chart.csv","w+")
	results.each{ |r|
		newcsv << r
	}
end

=begin







=end