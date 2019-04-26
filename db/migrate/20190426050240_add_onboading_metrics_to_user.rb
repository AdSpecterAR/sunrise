class AddOnboadingMetricsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :activity_level, :string
    add_column :users, :gender, :string
    add_column :users, :daily_notification_hour, :integer
    add_column :users, :daily_notification_minute, :integer
  end
end
