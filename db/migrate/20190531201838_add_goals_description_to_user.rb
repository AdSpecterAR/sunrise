class AddGoalsDescriptionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :goals_description, :string
  end
end
