require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

# check if there are emails to send each hour
scheduler.every '60m' do
  @reminders = Reminder.all
  @reminders.each do |reminder|
    if reminder.should_mail
      ReminderMailer.reminder_email(reminder).deliver
    end
  end
end