class MusicsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @musics = Music.all
  end
  
  def new
  end
  
  def show
    @music = Music.find(params[:id])
    @copy_users = @music.copy_users
    @want_users = @music.want_users
  end
end
