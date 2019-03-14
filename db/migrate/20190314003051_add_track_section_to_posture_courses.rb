class AddTrackSectionToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :posture_courses, :track_section, foreign_key: true, index: true
  end
end
