class AlbumsController < ApplicationController
  before_action :authenticate_user!,except: [:show]
  before_action :requireUpdate, only: [:edit,:destroy,:update]
  def index
    if user_signed_in?
      @published_albums = current_user.albums.where(published: true)
      @unpublished_albums = current_user.albums.where(published: false)
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end
 
  def create 
    @album = current_user.albums.new(album_params)
    
    if @album.save
      redirect_to @album 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update!(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to root_path, status: :see_other
  end

  def purge_img
    album = Album.find(params[:album_id])
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to album
  end

  private
    def album_params
      params.require(:album).permit(:title,:description,:published,:tagged,:cover_image,images:[])
    end

    def requireUpdate
      album = Album.find(params[:id])
      if current_user.id != album.user_id
        redirect_to root_path
      end
    end
end
