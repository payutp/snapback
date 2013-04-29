class Return < ActiveRecord::Base
  attr_accessible :status, :to_id, :user_id

  has_one :item
  has_one :reminder, :dependent => :destroy
  belongs_to :user 

end
