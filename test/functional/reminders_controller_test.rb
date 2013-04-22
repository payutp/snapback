require 'test_helper'

class RemindersControllerTest < ActionController::TestCase
  setup do
    @reminder = reminders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reminders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reminder" do
    assert_difference('Reminder.count') do
      post :create, reminder: { frequency: @reminder.frequency, last_sent: @reminder.last_sent, return_date: @reminder.return_date, return_id: @reminder.return_id, sent: @reminder.sent }
    end

    assert_redirected_to reminder_path(assigns(:reminder))
  end

  test "should show reminder" do
    get :show, id: @reminder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reminder
    assert_response :success
  end

  test "should update reminder" do
    put :update, id: @reminder, reminder: { frequency: @reminder.frequency, last_sent: @reminder.last_sent, return_date: @reminder.return_date, return_id: @reminder.return_id, sent: @reminder.sent }
    assert_redirected_to reminder_path(assigns(:reminder))
  end

  test "should destroy reminder" do
    assert_difference('Reminder.count', -1) do
      delete :destroy, id: @reminder
    end

    assert_redirected_to reminders_path
  end
end
