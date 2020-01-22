class PlaylistsController < ApplicationController
  
  def user_playlists
    @playlists=current_user.playlists.uniq
  end

  def index
    @playlists=Playlist.all
  end

  def show
    @playlist=Playlist.find_by(id: params[:id])
  end

  def new
      @playlist=current_user.playlists.build
  end

  def create
      verify_id
      @playlist=current_user.playlists.build(playlist_params)
      if @playlist.save
        redirect_to @playlist
      else
       render :new
      end
  end

  def edit
    @playlist=current_user.playlists.find_by(id: params[:id])
  end

  def update
    verify_id
    @playlist=current_user.playlists.find_by(id: params[:id])
    if @playlist.update(update_params)
      redirect_to @playlist
    else
      render :edit
    end
  end

  def destroy
    @playlist=current_user.playlists.find_by(id: params[:id])
    if @playlist
      @playlist.destroy
    end
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
