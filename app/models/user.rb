class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :perishable_token, :verified, :persistence_token

  has_secure_password
  
  # Simple validations.
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_format_of :email, :with => /@mit.edu/, :message => "is invalid. Must sign up with MIT email."

  has_many :lends
  has_many :returns
  has_many :tags

  def verify!
    self.verified = true
    self.save
  end

  def deliver_verification_instructions!  
	reset_perishable_token!  
	UserMailer.verification_email(self).deliver 
  end  

  def generate_perishable_token
  	o =  [('a'..'z'),('A'..'Z'),(1..9)].map{|i| i.to_a}.flatten
	random  =  (0...25).map{ o[rand(o.length)] }.join
	self.perishable_token = random
  end

end
