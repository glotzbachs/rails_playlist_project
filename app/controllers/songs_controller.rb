class SongsController < ApplicationController
  before_action :user_signed_in?
  
  def index
    @songs=Song.all
  end

  def show
    @song=Song.find_by(id: params[:id])
  end

  def new
    if user_signed_in?
      @song=current_user.songs.build
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @song=current_user.songs.build(song_params)
        if @song.save
          redirect_to @song
        else
          render :new
        end
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if user_signed_in?
      @song=current_user.songs.find_by(id: params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  def update
    if user_signed_in?
      @song=current_user.songs.find_by(id: params[:id])
      if @song.update(song_params)
        redirect_to @song
      else
        render :edit
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    @song=Song.find_by(id: params[:id])
    @song.destroy
    redirect_to songs_path
  end

 private
  def song_params
    params.require(:song).permit(:title, :artist, :album, :genre, :web_address, :user_id, :playlist_id, playlist_attributes: [:title])
  end
end
