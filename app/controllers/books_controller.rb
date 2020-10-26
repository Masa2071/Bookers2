class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book)
    # （）内でどのbookに飛ぶか指定
  end

  def show
    @book = Book.find(params[:id])
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
   redirect_to book_path(book)
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
