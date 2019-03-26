class AddActiveToViewedTrack < ActiveRecord::Migration[5.1]
  def change
    add_column :viewed_tracks, :active, :boolean
  end
end
