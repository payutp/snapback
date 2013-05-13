require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
	setup do
		@u1 = User.create(:email=>"a@mit.edu", :password=>"a")
    @u2 = User.create(:email=>"b@mit.edu", :password=>"ta")
	end

  test "general flow" do
  	post_via_redirect "/login"
  	assert_equal '/', path
  	assert_equal @u1.id, session[:user_id]
  end
end
