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
      flash.now[:alert] = "error"
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @books = [Book.find(params[:id])]
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(@book.id)  
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
  
end
