class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params) #ログインしているユーザーのidがコメントの生成をしている
    @book_comment.book_id = @book.id #投稿された内容のidをcommentのbook_idに代入　これでカラムが全て埋まる
    @book_comment.save
      #redirect_to book_path(@book.id)
    #else
     # render "books/show"
    #end
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
    # redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
