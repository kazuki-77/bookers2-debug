class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id]) #投稿されたbookのidを取得する
    favorite = current_user.favorites.new(book_id: @book.id) #ログインしているユーザーがいいねを生成している
    favorite.save
    #redirect_to books_path ここを消すことによって
    #リダイレクト先がない、かつJavaScriptリクエストという状況になる
    #そして、createアクション実行後は、create.js.erbファイルを探すようになる
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #redirect_to books_path 上と同じでdestroyアクション実行後は
    #destroy.js.erbファイルを探すようになる
  end

end
