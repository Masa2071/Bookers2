class BooksController < ApplicationController
 before_action :authenticate_user!
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
      # （）内でどのbookに飛ぶか指定
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    # 投稿したユーザの情報
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    # bookのユーザidとログイン中のidが一致した時のみ編集可能
    if @book.user_id == current_user.id
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
   book = Book.find(params[:id])
   book.update(book_params)
   redirect_to book_path(book), notice: 'You have created book successfully.'
  end

  def destroy
    book = Book.find(params[:id])
    if book.user_id == current_user.id
      book.destroy
      redirect_to books_path
    else
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
