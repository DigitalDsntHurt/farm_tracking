require 'rufus-scheduler'

s = Rufus::Scheduler.new

s.every '10m', :first_at => Time.now + 10 do 
	Scheduled.create(date: Date.today, verb: "sew", crop: "radish", variety: "purple sango", customer: "Liholiho Yacht Club", order: "111", completed_on: nil)
end