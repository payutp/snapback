require 'test_helper'

class UserReportsControllerTest < ActionController::TestCase
  setup do
    @user_report = user_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_report" do
    assert_difference('UserReport.count') do
      post :create, user_report: { description: @user_report.description, reported_user: @user_report.reported_user, user_id: @user_report.user_id }
    end

    assert_redirected_to user_report_path(assigns(:user_report))
  end

  test "should show user_report" do
    get :show, id: @user_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_report
    assert_response :success
  end

  test "should update user_report" do
    put :update, id: @user_report, user_report: { description: @user_report.description, reported_user: @user_report.reported_user, user_id: @user_report.user_id }
    assert_redirected_to user_report_path(assigns(:user_report))
  end

  test "should destroy user_report" do
    assert_difference('UserReport.count', -1) do
      delete :destroy, id: @user_report
    end

    assert_redirected_to user_reports_path
  end
end
