class Item < ActiveRecord::Base
  attr_accessible :lend_id, :name, :return_id

  belongs_to :lend
  belongs_to :return

  validates :name, :length => { :minimum => 1 }
end
