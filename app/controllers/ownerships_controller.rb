class OwnershipsController < ApplicationController
  def create
    
    #viewのhidden_field_tagが'Copy'の場合、選択したミュージックをコピーリストへ登録する
    if params[:type] == 'Copy'
      @music = Music.find(params[:music_id])
      current_user.copy(@music)
      flash[:success] = 'ミュージックをコピーリストへ登録しました'
    end

    #viewのhidden_field_tagが''Wantの場合、選択したミュージックをコピーしたいリストへ登録する
    if params[:type] == 'Want'
      @music = Music.find(params[:music_id])
      current_user.want(@music)
      flash[:success] = 'ミュージックをコピーしたいリストに登録しました'
    end
    
    redirect_back(fallback_location root_path)
      
  end

  def destroy
    
    #viewのhidden_field_tagが'Copy'の場合、選択したミュージックをコピーリストから削除する
    if params[:type] == 'Copy'
      @music = Music.find(params[:music_id])
      corrent_user.uncopy(@music)
      flash[:success] = 'ミュージックをコピーリストから削除しました'
    end
    
    #viewのhidden_field_tagが''Wantの場合、選択したミュージックをコピーしたいリストから削除する
    if params[:type] == 'Want'
      @music = Music.find(params[:music_id])
      corrent_user.unwant(@music)
      flash[:success] = 'ミュージックをコピーしたいリストから削除しました'
    end
    
    redirect_back(fallback_location root_path)
    
  end
end
