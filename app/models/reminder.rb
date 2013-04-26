class Reminder < ActiveRecord::Base
  attr_accessible :frequency, :last_sent, :return_date, :return_id, :sent

  belongs_to :return

  def get_user_to
  	return User.find_by_id(self.return.to)
  end

  def get_user_from
  	return User.find_by_id(self.return.user_id)
  end

end
