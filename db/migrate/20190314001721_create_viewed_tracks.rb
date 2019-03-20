class CreateViewedTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :viewed_tracks do |t|
      t.boolean :completed
      t.references :user, index: true, foreign_key: true
      t.references :track, index: true, foreign_key: true
    end
  end
end
