class Lend < ActiveRecord::Base
  attr_accessible :status, :to_id, :user_id, :photo, :photo_file_name
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "30x30>" },
        :default_url => "/images/:style/missing2.png",
        :url  => "/assets/lends/:id/:style/:basename.:extension",
        :path => ":rails_root/public/assets/lends/:id/:style/:basename.:extension"

  has_one :item
  belongs_to :user

  validates :item, :presence => true
  validates_associated :item
end
