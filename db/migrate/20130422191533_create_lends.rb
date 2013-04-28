class CreateLends < ActiveRecord::Migration
  def change
    create_table :lends do |t|
      t.string :status
      t.integer :to_id
      t.integer :user_id

      t.timestamps
    end
  end
end
