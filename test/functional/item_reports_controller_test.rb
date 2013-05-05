require 'test_helper'

class ItemReportsControllerTest < ActionController::TestCase
  setup do
    @item_report = item_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_report" do
    assert_difference('ItemReport.count') do
      post :create, item_report: { description: @item_report.description, item_id: @item_report.item_id, user_id: @item_report.user_id }
    end

    assert_redirected_to item_report_path(assigns(:item_report))
  end

  test "should show item_report" do
    get :show, id: @item_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_report
    assert_response :success
  end

  test "should update item_report" do
    put :update, id: @item_report, item_report: { description: @item_report.description, item_id: @item_report.item_id, user_id: @item_report.user_id }
    assert_redirected_to item_report_path(assigns(:item_report))
  end

  test "should destroy item_report" do
    assert_difference('ItemReport.count', -1) do
      delete :destroy, id: @item_report
    end

    assert_redirected_to item_reports_path
  end
end
