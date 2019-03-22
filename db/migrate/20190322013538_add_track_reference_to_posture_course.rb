class AddTrackReferenceToPostureCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :posture_courses, :track, foreign_key: true, index: true
  end
end
