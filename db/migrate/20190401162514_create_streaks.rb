class CreateStreaks < ActiveRecord::Migration[5.1]
  def change
    create_table :streaks do |t|
      t.datetime :first_course_date
      t.datetime :last_course_date
      t.boolean :active
      t.references :user, foreign_key: true, index: true
    end
  end
end
