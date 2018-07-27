class AddDescriptionToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :description, :text
    add_column :courses, :equipment, :string
  end
end
