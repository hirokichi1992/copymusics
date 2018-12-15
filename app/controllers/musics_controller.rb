class MusicsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @musics = Music.all
  end
  
  def new
    @artist = params[:artist]
    #アーティスト名が入力されているか確認
    if @artist.present?
      @artists = MusicBrainz::Artist.search(params[:artist])
      if @artists.count == 0
        flash[:danger] = "検索結果が存在しません。別のキーワードで試してください。"
        render 'new'
      end
    end
  end
  
  def artist
     @artist = MusicBrainz::Artist.find(params[:artist_id])
     @albums = @artist.release_groups
  end
  
  def album
    @artist = MusicBrainz::Artist.find(params[:artist_id])
    @album = MusicBrainz::ReleaseGroup.find(params[:album_id])
    @tracks = @album.releases.first.tracks
    #binding.pry...デバック時にここまでで処理が止まる（変数内に任意の値が正しく届いているかの確認に使う）
  end
 
  
  
  def show
    @music = Music.new(id: params[:music_id],
                       recording_id: params[:recording_id],
                       name: params[:name],
                       artist_name: params[:artist_name],
                       album_name: params[:album_name])
  end
end
