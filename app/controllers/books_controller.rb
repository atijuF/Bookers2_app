class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "successfully"
        redirect_to book_path(@book.id)
      else
        @user = current_user
        flash.now[:alert] = "error"
        @books = Book.all
        render :index
      end
  end

  def index
    @books = Book.page(params[:page])
    @user = current_user
    @book = Book.new
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    is_matching_login_user
  end
  
  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)  
    else
      render:edit
    end
  end
  
  def destroy
    book = Book.find(params[:id]) 
    book.destroy
    redirect_to '/books'
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
end
