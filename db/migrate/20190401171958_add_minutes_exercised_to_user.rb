class AddMinutesExercisedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :minutes_exercised, :integer
  end
end
