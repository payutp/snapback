class Reminder < ActiveRecord::Base
  attr_accessible :frequency, :last_sent, :return_date, :return_id, :sent

  belongs_to :return
end
