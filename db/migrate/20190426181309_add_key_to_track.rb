class AddKeyToTrack < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :key, :string
  end
end
