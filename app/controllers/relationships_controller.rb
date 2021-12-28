class RelationshipsController < ApplicationController
  before_action :authenticate_user! #ログインしていない人は遷移させないように

  def create
    follower = current_user.relationships.build(followed_id: params[:user_id])
    #ログインしているユーザーに.　紐づいたrelationshipsを作成. followed_id(フォローされる人)の中にuser_idを格納する
    follower.save
    redirect_to request.referrer || root_path #request.referrerで以前のpathに戻ることができる
  end

  def destroy
    follower = current_user.relationships.find_by(followed_id: params[:user_id])
    follower.destroy
    redirect_to request.referrer || root_path
  end

end
