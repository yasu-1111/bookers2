class UsersController < ApplicationController

before_action :baria_user, only: [:edit]

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully"
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def baria_user
      user = User.find(params[:id])
      if user != current_user
      redirect_to user_path(current_user)
      end
  end

end
