class CreateViewedTrackSections < ActiveRecord::Migration[5.1]
  def change
    create_table :viewed_track_sections do |t|
      t.boolean :completed
      t.references :track_section, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
