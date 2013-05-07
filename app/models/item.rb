class Item < ActiveRecord::Base
  attr_accessible :lend_id, :name, :return_id

  belongs_to :lend
  belongs_to :return
  has_many :item_reports
  has_and_belongs_to_many :tags

  validates :name, :length => { :minimum => 1 }
end
