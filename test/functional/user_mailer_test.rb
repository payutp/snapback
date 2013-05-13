require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
   setup do
    @user = User.create(:email=>"a@mit.edu", :password=>:"test")
  end

  test "sent welcome" do
  	# Send the email, then test that it got queued
    email = UserMailer.welcome_email(@user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test the sent email contains what we expect it to
    assert_equal [@user.email], email.to
    assert_equal "Welcome to SnapBack", email.subject
  end

end
