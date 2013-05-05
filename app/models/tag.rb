class Tag < ActiveRecord::Base
  attr_accessible :tag
  has_and_belongs_to_many :lends
  belongs_to :user
end
