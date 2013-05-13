require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
    @lend = lends(:one)
    @return = returns(:one)
    @item.lend = @lend
    @item.return = @return
  end

  test "should return item" do
    post :return, {:id => @item.id}

    assert_redirected_to activity_path
  end
end
