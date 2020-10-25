class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
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
