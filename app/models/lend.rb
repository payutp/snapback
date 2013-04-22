class Lend < ActiveRecord::Base
  attr_accessible :status, :to, :user_id

  has_one :item

  belongs_to :user

end
