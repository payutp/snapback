class Tag < ActiveRecord::Base
  attr_accessible :tag
  has_and_belongs_to_many :items
  belongs_to :user
end
