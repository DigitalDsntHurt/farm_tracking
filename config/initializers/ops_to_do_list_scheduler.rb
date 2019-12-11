require 'rufus-scheduler'

##
## ## Schedule next week's soak list every saturday at 1am
##
scheduler = Rufus::Scheduler.new

scheduler.cron '0 1 * * 6' do
	SoakSchedule.instantiate_weekly_soak_schedule_db_dos # creates weekly soak schedule
	SewSchedule.instantiate_weekly_sew_schedule_db_dos # creates weekly sew schedule
end