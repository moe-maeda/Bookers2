class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new
    @book.save
    redirect_to about_path
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
