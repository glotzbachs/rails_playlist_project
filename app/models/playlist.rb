class Playlist < ApplicationRecord
    has_many :songs
    has_many :users, through: :songs

    validates :title, presence: true

    def songs_attributes=(songs_attributes)
        songs_attributes.values.each do |song_attribute|
            if song_attribute[:name]!=""
                song=Song.find_or_create_by(song_attribute)
                self.songs << song
            end
        end
    end

    def song_count
        self.songs.count
    end

    def alphabetically_by_title
        self.songs.collect {|song| song.title.sort}
    end

    def alphabetically_by_artist
        self.songs.collect {|song| song.artist.sort}
    end

    def alphabetically_by_genre
        self.songs.collect {|song| song.genre.sort}
    end

    def alphabetically_by_album
        self.songs.collect {|song| song.album.sort}
    end


end
