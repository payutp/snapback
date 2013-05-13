require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
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

  test "get user to" do
  	assert_equal @reminder.get_user_to, @user_to
  end

  test "get user from" do
  	assert_equal @reminder.get_user_from, @user_from
  end
end
