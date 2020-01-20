class AddColumnsToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :user_id, :integer
    add_column :songs, :playlist_id, :integer
  end
end
