class CreateUserReports < ActiveRecord::Migration
  def change
    create_table :user_reports do |t|
      t.string :description
      t.integer :user_id
      t.integer :reported_user

      t.timestamps
    end
  end
end
