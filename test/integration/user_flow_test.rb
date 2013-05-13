require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(:email => 'steph', :password => 'a')
  end

	test "login and then logout" do
		xhr :post, "/sessions", { :email => 'steph', :password => 'a' }
		assert_response 200

		xhr :delete, "/sessions/:id" 
		assert_response 302
	end
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
