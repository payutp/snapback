class CreateLendsTags < ActiveRecord::Migration
  def change
    create_table :lends_tags, :id => false do |t|
      t.integer :lend_id
      t.integer :tag_id
    end
  end
end