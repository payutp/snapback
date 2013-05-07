class UserReport < ActiveRecord::Base
  attr_accessible :description, :reported_user, :user_id
  belongs_to :user # user that created the report
  validates_presence_of :reported_user 
end
