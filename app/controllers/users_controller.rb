class UsersController < ApplicationController

  def create
    @user_sign_up = User.new(user_params)
    if @user_sign_up.save
      flash[:notice] = "Welcome! You have signed up successfully."
    end
    @user = login(params[:name], params[:password])
    if @user
      flash[:notice] = "Signed in successfully."
    end
  end

  def index
    @users = User.all
    @user_info = current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @user_info = @user
    @book_new= Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    logout
    flash[:notice] = "Signed out successfully."
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
