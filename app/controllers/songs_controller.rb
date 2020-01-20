class SongsController < ApplicationController
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
        @song.user_id=current_user.id
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
      if @song.update
        redirect_to @song
      else
        render :edit
      end
    else
      redirect_to new_user_session_path
    end
  end

 private
  def song_params
    params.require(:song).permit(:title, :artist, :album, :genre, :web_address, :user_id, :playlist_id, playlist_attributes: [:title, :description])
  end
end
