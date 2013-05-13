require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:email => 'foo@mit.edu', :password => 'bar', :password_confirmation => 'bar')
    session[:user_id] = @user.id
    @item = Item.create(:name => "test", :lend_id => @user.id)
    @lend = @user.lends.create(:status => "pending", :to_id => @user.id, :user_id => @user.id)
    @lend.id = 1
    @lend.save
    @return = Return.create(:status => "pending", :to_id => @user.id, :user_id => @user.id)
    @item.lend = @lend
    @item.return = @return

    @item.save
  end

  teardown do
    @user.delete
    @item.delete
    @lend.delete
    @return.delete
  end

  test "should get all tags" do
    xhr :post, :index, {:id => "all"}
    assert_equal "Success", json_response['msg']
  end

  test "should create tag" do
    post :create, {:tag => {:tag => "test"}}
    assert_equal "Tag was successfully created.", flash[:notice]
  end
end
