require 'test_helper'

class ItemReportsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:email=>"a@mit.edu", :password=>:"test")
    @lend = @user.lends.create(:to_id => @user.id)
    @item = @lend.create_item(:name=>"test item")
    @request.env['HTTP_REFERER'] = 'localhost:3000'
    session[:user_id] = @user.id
  end

  test "should create" do
  	assert ItemReport.all.size == 0
  	post :create, {:item_id => @item.id, :description => "test"}
  	assert ItemReport.all.size == 1

  	report = ItemReport.all.first
  	assert_equal "test", report.description
  end
end
