class SongsController < ApplicationController
  # before_action :require_login
  
  def index
    # binding.pry
    if params[:search]
      @songs=Song.by_genre(params[:search])
    else
      @songs=Song.all
    end
  end

  def user_songs
    @songs=current_user.songs
  end

  def show
    @song=Song.find_by(id: params[:id])
  end

  def new
      @song=current_user.songs.build
  end

  def create  
      @song=current_user.songs.build(song_params)
        if @song.save
          redirect_to @song
        else
          render :new
        end
  end

  def edit
      @song=current_user.songs.find_by(id: params[:id])
  end

  def update
      @song=current_user.songs.find_by(id: params[:id])
      if @song.update(song_params)
        redirect_to @song
      else
        render :edit
      end
  end

  def destroy
    @song=current_user.songs.find_by(id: params[:id])
    if @song
      @song.destroy
    end
    redirect_to songs_path
  end

 private
  def song_params
    params.require(:song).permit(:title, :artist, :album, :genre, :web_address, :user_id, :playlist_id, playlist_attributes: [:title])
  end

  def verify_id
    if params[:user_id]!= current_user.id
      params[:user_id]=current_user.id
    end
  end
end
