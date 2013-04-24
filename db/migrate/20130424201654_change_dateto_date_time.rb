class ChangeDatetoDateTime < ActiveRecord::Migration
  def up
  	remove_column :reminders, :return_date
  	remove_column :reminders, :last_sent

  	add_column :reminders, :return_date, :datetime
  	add_column :reminders, :last_sent, :datetime  	
  end

  def down
   	remove_column :reminders, :return_date
  	remove_column :reminders, :last_sent

  	add_column :reminders, :return_date, :date
  	add_column :reminders, :last_sent, :date  	
  end
end
