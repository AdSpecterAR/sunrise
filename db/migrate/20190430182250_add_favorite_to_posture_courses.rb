class AddFavoriteToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :posture_courses, :completed_count, :integer, default: 0
    add_column :posture_courses, :favorited_count, :integer, default: 0
    add_column :posture_courses, :view_count, :integer, default: 0

    add_column :posture_courses, :last_completed_at, :datetime
    add_column :posture_courses, :last_favorited_at, :datetime
    add_column :posture_courses, :last_viewed_at, :datetime
  end
end
