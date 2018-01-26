class HarvestCalculator
  def self.hc(crop, weight, date)
  	@answer_crop = crop.capitalize
  	@answer_flats = weight.to_f * 2
  	@tmp_date = ""
  	date.each{|k,v|
  		@tmp_date += "#{v}-"
  	}
  	@answer_date = @tmp_date[0..-2].to_date

  	@text_query = SeedFlat.all.count
  	"=> To get #{weight} LBS of #{@answer_crop} by #{@answer_date} ~~ Sew #{@answer_flats} flats on #{@answer_date - 15}"
  end
end