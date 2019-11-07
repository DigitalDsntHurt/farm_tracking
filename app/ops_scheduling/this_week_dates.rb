module ThisWeekDates
	@today = Date.today
    
    def self.monday
    	@monday = @today	
		unless @monday.monday?
	      until @monday.monday?
	        @monday -= 1
	      end
	    end

	    @monday    	
    end

    def self.wednesday
    	monday + 2
    end
    
    def self.friday
    	wednesday + 2
    end
end