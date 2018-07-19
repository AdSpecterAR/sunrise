class AddAccountTypesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :instructor, :boolean

    remove_column :users, :account_type
    remove_column :courses, :start_date
  end
end
