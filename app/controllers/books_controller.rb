class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
      @user = current_user
      @book = Book.new(book_params)
      @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else flash[:notice] ="error"
       @books = Book.all
      render:index
    end
  end

  def index
    @books = Book.all
    @user = current_user
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] =""
       redirect_to book_path(@book.id)
    else flash[:notice] ="error"
      @books = Book.all
      render:edit
    end
  end

  def destroy
      book = Book.find(params[:id])
    if book.destroy
       redirect_to '/books'
       flash[:notice] ="successfully"
    else flash[:notice] ="error"
      @books = Book.all
       render:index
    end
  end

private

  def book_params
    params.require(:book).permit(:title,:body)
  end

   def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
      redirect_to post_images_path
      end
    end
end
