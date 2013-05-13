require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
	
	setup do
	    @user = User.create( :email => 'steph', :password => 'a')
	    session[:user_id] = @user.id
  	end

  	test "login" do
	    xhr :post, :create, { :email => 'steph', :password => 'a' }
	    assert_response 200
  	end

  	test "logout" do
	    xhr :delete, :destroy
	    assert_response 302
  	end

end
