class Reminder < ActiveRecord::Base
  attr_accessible :frequency, :last_sent, :return_date, :return_id, :sent
  belongs_to :return
  after_create :set_default

  # start sent at 0
  def set_default
    self.sent = 0
  end

  def get_user_to
  	return User.find_by_id(self.return.to_id)
  end

  def get_user_from
  	return User.find_by_id(self.return.user_id)
  end

  # returns true if should mail a reminder, false otherwise
  # calculates this based on the frequency and when last sent
  # frequency: 
  # 1 = daily
  # 2 = every other day
  # 4 = every 7 days
  # 5 = every 14 days
  def should_mail
    if self.return.status == "close"
      return false
    end
    if !self.last_sent
      return true
    elsif self.frequency == 1 and self.last_sent + 1.days <= DateTime.now
      return true
    elsif self.frequency == 2 and self.last_sent + 2.days <= DateTime.now
      return true
     elsif self.frequency == 3 and self.last_sent + 7.days <= DateTime.now
      return true   
    elsif self.frequency == 4 and self.last_sent + 14.days <= DateTime.now
      return true
    else
      return false
    end      
  end

end
