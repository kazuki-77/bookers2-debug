class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params) #ログインしているユーザーのidがコメントの生成をしている
    comment.book_id = book.id #投稿された内容のidをcommentのbook_idに代入　これでカラムが全て埋まる
    comment.save
    redirect_to book_path(book)
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
