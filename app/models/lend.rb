class Lend < ActiveRecord::Base
  attr_accessible :status, :to_id, :user_id

  has_one :item

  belongs_to :user

  validates :item, :presence => true
  validates_associated :item
end
