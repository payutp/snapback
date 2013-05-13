require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "rating return on time" do
  	user = User.new 
  	prev_rating = user.rating

  	curr_date = DateTime.new(2013, 5, 1)
  	return_date = DateTime.new(2013, 5, 2)
  	user.update_rating(curr_date, return_date)
    assert user.rating == prev_rating
  end

  test "rating return two days late" do
  	user = User.new 
  	prev_rating = user.rating

  	curr_date = DateTime.new(2013, 5, 4)
  	return_date = DateTime.new(2013, 5, 2)
  	user.update_rating(curr_date, return_date)
    assert user.rating == 4
  end

  test "rating manual" do
    user = User.new 
    prev_rating = user.rating

    user.update_rating_manual(1) 
    assert user.rating == 3   
  end

end
