class AddProfilePicText < ActiveRecord::Migration
  def up
  	add_column :users, :picture, :text
  end
end
