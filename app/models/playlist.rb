class Playlist < ApplicationRecord
    has_many :songs
    has_many :users, through: :songs

    validates :title, presence: true

    def songs_attributes=(songs_attributes)
        songs_attributes.values.each do |song_attribute|
            if song_attribute[:title]!=""
                song=Song.find_or_create_by(song_attribute)
                self.songs << song
            end
        end
    end

    def song_count
        self.songs.count
    end

end
