require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:email => 'foo@mit.edu', :password => 'bar', :password_confirmation => 'bar')
    session[:user_id] = @user.id
    @item = Item.create(:name => "test", :lend_id => @user.id)
    @lend = @user.lends.create(:status => "pending", :to_id => @user.id, :user_id => @user.id)
    @lend.id = 1
    @return = Return.create(:status => "pending", :to_id => @user.id, :user_id => @user.id)
    @lend.item = @item
    @item.return = @return

    @item.save
  end

  teardown do
    @user.delete
    @item.delete
    @lend.delete
    @return.delete
  end

  test "should return item" do
    post :return, {:id => @item.id}
    assert_redirected_to activity_path
  end

  test "should confirm item" do
    post :return, {:id => @item.id}
    assert_redirected_to activity_path
  end  
end
