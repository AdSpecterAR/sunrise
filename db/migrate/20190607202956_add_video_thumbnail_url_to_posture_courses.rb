class AddVideoThumbnailUrlToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :posture_courses, :video_thumbnail_url, :string
  end
end
