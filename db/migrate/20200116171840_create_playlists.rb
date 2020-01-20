class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :title
      t.integer :song_id
      t.integer :user_id

      t.timestamps
    end
  end
end
