class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.date :return_date
      t.integer :frequency
      t.integer :return_id
      t.integer :sent
      t.date :last_sent

      t.timestamps
    end
  end
end
