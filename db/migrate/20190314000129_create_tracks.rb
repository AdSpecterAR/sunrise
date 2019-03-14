class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.string :intro_video_url
      t.references :user, index: true, foreign_key: true
    end
  end
end
