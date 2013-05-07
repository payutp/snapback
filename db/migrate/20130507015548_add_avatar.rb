class AddAvatar < ActiveRecord::Migration
  def up
  	add_attachment :users, :avatar
  	remove_column :users, :picture
  end

  def down
  	remove_attachment :users, :avatar
  	add_column :users, :picture, :text
  end
end
