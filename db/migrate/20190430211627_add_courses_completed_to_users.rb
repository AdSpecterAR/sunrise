class AddCoursesCompletedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :courses_completed_count, :integer
  end
end
