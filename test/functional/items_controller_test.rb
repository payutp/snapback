require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should return item" do
    post :return, {:id => @item.id}

    assert_redirected_to activity_path
  end
end
