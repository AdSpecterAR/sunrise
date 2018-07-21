class CreateUserCourseSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_course_sessions do |t|
      t.belongs_to :student, index: true, foreign_key: {to_table: :users }
      t.belongs_to :course_session, index: true
      t.string :rating
      t.string :comment

      t.timestamps
    end
  end
end
