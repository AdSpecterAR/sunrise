class AddSetupInstructionToPostureCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :posture_courses, :setup_instructions, :text
  end
end
