class AddCourseSessionsToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :course_sessions, :course, index: true, foreign_key: true
  end
end
