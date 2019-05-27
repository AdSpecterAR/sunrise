class AddCourseTypeToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :posture_courses, :course_type, :string
  end
end
