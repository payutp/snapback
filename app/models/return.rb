class Return < ActiveRecord::Base
  attr_accessible :status, :to, :user_id

  has_one :item
  has_one :reminder
  belongs_to :user 

  after_create :create_default

  # create blank reminder automatically
  def create_default
  	self.create_reminder
 	self.reminder.sent = 0
 	self.reminder.save
  end
end
