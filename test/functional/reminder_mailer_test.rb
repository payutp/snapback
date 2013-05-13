require 'test_helper'

class ReminderMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user_to = User.create(:email=>"a@mit.edu", :password=>:"test")
    @user_from = User.create(:email=>"b@mit.edu", :password=>"test")
    ret = @user_from.returns.create(:to_id => @user_to.id)
    ret.create_item(:name=>"test item")
    @reminder = ret.create_reminder(:frequency => 1, :return_date=> DateTime.now + 3.days)

  end

  test "sent reminder" do
  	# Send the email, then test that it got queued
    email = ReminderMailer.reminder_email(@reminder).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test the sent email contains what we expect it to
    assert_equal [@user_to.email], email.to
    assert_equal "Reminder: Return Item", email.subject
  end
end
