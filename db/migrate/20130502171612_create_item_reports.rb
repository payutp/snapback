class CreateItemReports < ActiveRecord::Migration
  def change
    create_table :item_reports do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :description

      t.timestamps
    end
  end
end
