class CreateTrackSections < ActiveRecord::Migration[5.1]
  def change
    create_table :track_sections do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.string :intro_video_url
      t.integer :number
      t.references :track, index: true, foreign_key: true
    end
  end
end
