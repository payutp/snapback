namespace :send_reminders do
  desc "" #task describtion
  task :send_reminders_task => :environment do
     send_reminders
  end

  def send_reminders
    @reminders = Reminder.all
    @reminders.each do |reminder|
      if reminder.return_date >= DateTime.now
        ReminderMailer.reminder_email(reminder).deliver
      end
    end
  end
end