class Lend < ActiveRecord::Base
  attr_accessible :status, :to_id, :user_id

  has_one :item
  has_and_belongs_to_many :tags
  belongs_to :user

  validates :item, :presence => true
  validates_associated :item
end
