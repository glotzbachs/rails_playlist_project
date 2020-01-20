class RemoveColumnsFromPlaylists < ActiveRecord::Migration[6.0]
  def change
    remove_column :playlists, :user_id, :integer
    remove_column :playlists, :song_id, :integer
  end
end
