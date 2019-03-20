class CreateViewedPostureCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :viewed_posture_courses do |t|
      t.boolean :completed
      t.references :posture_course, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
