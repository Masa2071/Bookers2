class UsersController < ApplicationController
 before_action :authenticate_user!
 
  def index
    # ユーザの全データ取得
    @users = User.all
    # ログイン中のユーザデータ取得
    @user = current_user
    #新規投稿
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
  # form_withでbookモデルをbook_pathに渡すため
    @book = Book.new

    @user = User.find(params[:id])
    # そのユーザーに関連したbooksのみ
    @books = @user.books
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
