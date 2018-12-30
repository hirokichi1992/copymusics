class ToppagesController < ApplicationController
  def index
    @musics = Music.all.page(params[:page]).per(10)
  end
end
