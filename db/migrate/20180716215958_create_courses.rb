class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.datetime :start_date
      t.integer :duration
      t.string :category
      t.string :difficulty

      t.timestamps
    end
  end
end
