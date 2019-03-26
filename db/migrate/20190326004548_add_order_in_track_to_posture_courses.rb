class AddOrderInTrackToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :posture_courses, :order_in_track, :integer, unique: true
  end
end
