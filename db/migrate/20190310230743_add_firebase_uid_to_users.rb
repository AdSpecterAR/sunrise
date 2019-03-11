class AddFirebaseUidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firebase_uid, :string
    add_index :users, :firebase_uid
  end
end
