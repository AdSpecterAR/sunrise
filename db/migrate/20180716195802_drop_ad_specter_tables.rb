class DropAdSpecterTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :ad_units
    drop_table :api_keys
    drop_table :app_sessions
    drop_table :developer_apps
    drop_table :devices
    drop_table :impressions
  end
end
