class AddFavoritedToViewedPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :viewed_posture_courses, :last_completed_at, :datetime
    add_column :viewed_posture_courses, :last_favorited_at, :datetime
    add_column :viewed_posture_courses, :last_viewed_at, :datetime

    add_column :viewed_posture_courses, :completed_count, :integer, default: 0
    add_column :viewed_posture_courses, :favorite, :boolean, default: false
    add_column :viewed_posture_courses, :view_count, :integer, default: 0
  end
end
