class BooksController < ApplicationController

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new.id)
    else
      render :show
    end
  end

  def index
    @books = Book.includes(:user).all
    @user = current_user
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
