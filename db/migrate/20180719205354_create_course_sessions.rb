class CreateCourseSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :course_sessions do |t|
      t.datetime :start_time
      t.integer :duration
      t.string :video_url
      t.string :thumbnail_image_url

      t.timestamps
    end
  end
end
