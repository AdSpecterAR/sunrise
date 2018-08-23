class AddLiveToCourseSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :course_sessions, :live, :boolean
  end
end
