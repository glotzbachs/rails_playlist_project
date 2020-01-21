class PlaylistsController < ApplicationController
  before_action :user_signed_in?

  def index
    @playlists=Playlist.all
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
      verify_id
      @playlist=current_user.playlists.build(playlist_params)
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
    if @playlist.update(update_params)
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
    params.require(:playlist).permit(:title, :description, :user_id, song_ids:[], songs_attributes: [:title, :user_id, :playlist_id])
  end

  def update_params
    params.require(:playlist).permit(:title, :description)
  end

  def verify_id
    if params[:user_id]!= current_user.id
      params[:user_id]=current_user.id
    end
  end
end
