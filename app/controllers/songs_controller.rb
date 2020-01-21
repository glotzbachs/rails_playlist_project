class SongsController < ApplicationController
  # before_action :require_login
  
  def index
    @songs=Song.all
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
    @song.destroy
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
