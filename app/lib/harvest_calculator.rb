class HarvestCalculator
  
  def self.hc(crop, weight, date)
  	@answer_crop = crop.capitalize

    #get start dates where crop has been harvested
    sow_dates = SeedFlat.where(crop: crop).where.not(harvested_on: nil).pluck(:started_date)

    #now get harvest date for same crops
    harvest_dates = SeedFlat.where(crop: crop).where.not(harvested_on: nil).pluck(:harvested_on)

    #subtract dates from each to get difference in days between sow and harvest for crop
    #must done in loop because I cant call to_i internally during subtraction
    difference = []
    harvest_dates.zip(sow_dates).each do |harvest, sow|
      #add each difference to array
      difference += [(harvest - sow).to_i]
    end

    average = (difference.reduce(:+) / difference.size.to_f).to_i


  	@answer_flats = weight.to_f * 2
  	
    @tmp_date = ""
  	
    date.each{|k,v|
  		@tmp_date += "#{v}-"
  	}
  	@answer_date = @tmp_date[0..-2].to_date

  	@text_query = SeedFlat.all.count


  "=> To get #{weight} LBS of #{@answer_crop} by #{@answer_date} ~~ Sew #{@answer_flats} flats on #{@answer_date - average}"
  
  
  end
end