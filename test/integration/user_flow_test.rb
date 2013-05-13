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
end
