class OwnershipsController < ApplicationController
  
  def create
    #viewのhidden_field_tagが'Copy'の場合、選択したミュージックをコピーリストへ登録する
    if params[:type] == 'Copy'
      @music = Music.find_or_create_by(recording_id: params[:recording_id],
                                               name: params[:name],
                                        artist_name: params[:artist_name],
                                         album_name: params[:album_name] )
      current_user.copy(@music)
      flash[:success] = "#{@music.name}をコピーリストへ登録しました"
      #binding.pry
    end

    #viewのhidden_field_tagが''Wantの場合、選択したミュージックをコピーしたいリストへ登録する
    if params[:type] == 'Want'
      @music = Music.find_or_create_by(recording_id: params[:recording_id],
                                               name: params[:name],
                                        artist_name: params[:artist_name],
                                         album_name: params[:album_name] )
      current_user.want(@music)
      flash[:success] = "#{@music.name}をコピーしたいリストに登録しました"
    end
    
    redirect_back(fallback_location: root_path)
      
  end

  def destroy
    #viewのhidden_field_tagが'Copy'の場合、選択したミュージックをコピーリストから削除する
    if params[:type] == 'Copy'
      @music = Music.find(params[:music_id])
      current_user.uncopy(@music)
      flash[:success] = "#{@music.name}をコピーリストから削除しました"
    end
    
    #viewのhidden_field_tagが''Wantの場合、選択したミュージックをコピーしたいリストから削除する
    if params[:type] == 'Want'
      @music = Music.find(params[:music_id])
      current_user.unwant(@music)
      flash[:success] = "#{@music.name}をコピーしたいリストから削除しました"
    end
    
    redirect_back(fallback_location: root_path)
    
  end
end
