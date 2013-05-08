class AddImageToLend < ActiveRecord::Migration
  def up
  	add_attachment :lends, :photo
  end

  def down
  	remove_attachment :lends, :photo
  end
end
