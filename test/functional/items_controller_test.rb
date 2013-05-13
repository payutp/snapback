require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = Item.new
    @lend = Lend.new
    @return = Return.new
    @item.lend = @lend
    @item.return = @return
  end

  # test "should return item" do
  #   post :return, {:id => @item.id}

  #   assert_redirected_to activity_path
  # end
end
