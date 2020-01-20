class PlaylistsController < ApplicationController
  def index
    @playlists=current_user.playlists
  end

  def show
    @playlist=Playlist.find_by(id: params[:id])
  end

  def new
    if user_signed_in?
      @playlist=current_user.playlists.build
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @playlist=current_user.playlists.build(playlist_params)
      binding.pry
      if @playlist.save
        redirect_to @playlist
      else
       render :new
      end
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @playlist=Playlist.find_by(id: params[:id])
  end

  def update
    @playlist=Playlist.find_by(id: params[:id])
    if @playlist.update
      redirect_to @playlist
    else
      render :edit
    end
  end

  def destroy
    @playlist=Playlist.find_by(id: params[:id])
    @playlist.destroy
    redirect_to playlists_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :user_id, song_ids:[], songs_attributes: [:name])
  end
end
