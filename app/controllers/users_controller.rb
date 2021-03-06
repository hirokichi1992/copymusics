class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
      redirect_to @user
    else
      flash[:danger] = 'ユーザーの登録に失敗しました'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を修正しました'
      redirect_to @user
    else
      flash[:success] = 'ユーザー情報を修正できませんでした'
      render "edit"
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(5)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(5)
    counts(@user)
  end

  def wants
    @user = User.find(params[:id])
    @wants = @user.want_musics.page(params[:page]).per(5)
    counts(@user)
  end

  def copys
    @user = User.find(params[:id])
    @copys = @user.copy_musics.page(params[:page]).per(5)
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :age, :part, :password, :password_confirmation)
  end
end
