class CreatePostureCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :posture_courses do |t|
      t.string :name
      t.integer :duration
      t.string :category
      t.string :difficulty
      t.text :equipment
      t.text :description
      t.string :video_url
      t.string :gif_url
      t.string :audio_url
      t.string :thumbnail_image_url
    end
  end
end
