require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
	setup do
		@u1 = User.create(:email=>"a@mit.edu", :password=>"a")
    @u2 = User.create(:email=>"b@mit.edu", :password=>"ta")
	end
end
