class MusicsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @musics = Music.all
  end
  
  def new
    @albums_name = []
    @artist_name = []
    @music_names = []
    @albums = []
    @musics = []
    @artist = params[:artist]
    #アーティスト名が入力されているか確認
    if @artist.present?
      artist = MusicBrainz::Artist.find_by_name(params[:artist])
      #APIの結果にアーティスト名が存在するか確認
      if artist.present?
        @artist_info = artist
        
        
        # @artist = artist.name
        
        
        #アルバム一覧検索（お試し）
        #@artist_name = artist.name
        #albums = artist.release_groups.map{|o|o.title}
        #@albums_name = albums
        
        
        # artist.release_groups.each do |release_group|
        #   #アルバム検索
        #   release_group.releases.each do |release|
        #     album_names = release.title
        #     @albums << album_names
        #     #アルバム内トラック検索
        #     release.tracks.each do |track|
        #       music_names = track.title
        #       @musics << music_names
        #     end
        #   end
        # end
        # @musics_name = @music_names.map{|o|o.title}
      else
        flash[:danger] = 'アーティスト名を入力してください'
        render 'new'
      end
    end
  end
  
 
  #例外処理(検索キーワードの楽天仕様でのエラー回避)
  #rescue => e
  #  flash[:danger] = '検索結果が存在しません'
  #end
  
  def show
    @music = Music.new( id: params[:id],
                        recording_id: params[:recording_id],
                        name: params[:name],
                        artist_id: params[:artist_id],
                        album_id: params[:album_id])
  end
end
