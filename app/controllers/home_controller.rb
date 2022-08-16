class HomeController < ApplicationController
  def index
    @q = Album.where(published:true).ransack(params[:q])
    @albums = @q.result
  end
end
