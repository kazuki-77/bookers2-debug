class BooksController < ApplicationController
before_action :correct_user, only: [:edit, :update]
  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @user =@books.user
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'books/index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user = current_user
      render :edit
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private
  def correct_user
    user = Book.find(params[:id]).user
    if current_user.id != user.id
      redirect_to books_path
    end

  end

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
