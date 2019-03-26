class AddActiveToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :posture_courses, :active, :boolean
  end
end
