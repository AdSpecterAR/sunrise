class RemoveTrackSection < ActiveRecord::Migration[5.1]
  def change
    remove_reference :posture_courses, :track_section, index: true, foreign_key: true
    remove_reference :viewed_track_sections, :track_section, index: true, foreign_key: true

    drop_table :track_sections
    drop_table :viewed_track_sections
  end
end
