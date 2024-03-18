class BooksController < ApplicationController
  before_action :is_matching_book_user, only: [:edit, :update]

  def create
    @book_new = Book.new(book_params)
    @user_info = current_user
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.includes(:user).all
      render :index
    end
  end

  def index
    @books = Book.includes(:user).all
    @user_info = current_user
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user_info = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
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

  def is_matching_book_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
