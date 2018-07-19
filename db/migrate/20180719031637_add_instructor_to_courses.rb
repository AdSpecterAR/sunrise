class AddInstructorToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :instructor, index: true, foreign_key: { to_table: :users }
  end
end
