class ReminderMailer < ActionMailer::Base
  default from: "snapbackapp@gmail.com"

  def reminder_email(reminder)
    /return_request = Return.find(reminder.return_id)
    @user_to = @reminder.get_user_to
    @user_from = @reminder.get_user_from
    @item = @return_request.item
    @return_date = @reminder.return_date
    # Update reminder 
    reminder.last_sent = DateTime.now
    reminder.sent = reminer.sent + 1
    reminder.save/

    # testing code for now
    # can run ReminderMailer.remind_email(blah).deliver in console
    @user_to = User.all.first
    @item = Item.all.first
    @return_date = DateTime.now

    mail(:to => @user_to.email, :subject => "Reminder: Return Item")
  end
end
