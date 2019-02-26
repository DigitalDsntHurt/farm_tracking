require 'rufus-scheduler'

s = Rufus::Scheduler.new

s.every '30m' do #, :first_at => Time.now + 10 
	Scheduled.create(date: Date.today, verb: "sew", crop: "radish", variety: "purple sango", customer: "Liholiho Yacht Club", order: "111", completed_on: nil)
end