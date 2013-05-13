require 'test_helper'

class LendRequestTest < ActionDispatch::IntegrationTest
	setup do
	   @u1 = User.create(:email=>"a@mit.edu", :password=>"a")
	   @u2 = User.create(:email=>"b@mit.edu", :password=>"ta")
	   @u1.verify!
	   @u2.verify!
	end

  test "lend request" do
		xhr :post, "/sessions", { :email => "a@mit.edu", :password => "a" }
        xhr :post, "/lends", {:lend => {}, :item_name => "test", :tags => ""}
  		assert_equal "test", Item.first.name
  end
end
