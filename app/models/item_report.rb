class ItemReport < ActiveRecord::Base
  attr_accessible :description, :item_id, :user_id
  belongs_to :user 
  belongs_to :item
end
