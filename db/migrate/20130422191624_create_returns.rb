class CreateReturns < ActiveRecord::Migration
  def change
    create_table :returns do |t|
      t.string :status
      t.integer :to
      t.integer :user_id

      t.timestamps
    end
  end
end
