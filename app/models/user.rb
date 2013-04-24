class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  has_secure_password 
  
  # Simple validations.
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  has_many :lends
  has_many :returns

end