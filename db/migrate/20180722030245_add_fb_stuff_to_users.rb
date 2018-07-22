class AddFbStuffToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fb_authentication_token, :string
    add_column :users, :fb_user_id, :string
    add_column :users, :fb_account, :boolean
  end
end
