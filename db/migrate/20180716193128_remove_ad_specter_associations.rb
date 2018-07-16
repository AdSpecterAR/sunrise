class RemoveAdSpecterAssociations < ActiveRecord::Migration[5.1]
  def change
    remove_reference :ad_units, :user, index: true, foreign_key: true
    remove_reference :api_keys, :developer_app, index: true, foreign_key: true
    remove_reference :app_sessions, :developer_app, index: true, foreign_key: true
    remove_reference :developer_apps, :user, index: true, foreign_key: true
    remove_reference :devices, :app_session, index: true, foreign_key: true
    remove_reference :impressions, :ad_unit, index: true, foreign_key: true
    remove_reference :impressions, :app_session, index: true, foreign_key: true
    remove_reference :impressions, :developer_app, index: true, foreign_key: true
  end
end
