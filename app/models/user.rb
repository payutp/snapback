class User < ActiveRecord::Base
  attr_accessible :email

  has_many :lends
  has_many :returns

end
