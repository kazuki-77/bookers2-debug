class BookCommentsController < ApplicationController

  def create
    @books = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params) #ログインしているユーザーのidがコメントの生成をしている
    @book_comment.book_id = book.id #投稿された内容のidをcommentのbook_idに代入　これでカラムが全て埋まる
    if @book_comment.save
      redirect_to book_path(@book.id)
    else
      render "books/show"
    end
  end

  def destroy
    BookComment.find_by(id: params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
