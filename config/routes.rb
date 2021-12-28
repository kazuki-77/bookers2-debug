Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy] #userとネストする
    get :followers, on: :member #あるユーザーがフォローしている人全員を表示させるためのルーティング
    get :followeds, on: :member #あるユーザーをフォローしている人（フォロワー）の一覧画面を表示させるためのルーティング
    #on: :member でルーティングに:idを含めることができる
  end

  resources :books do #ネストするときは親の末尾に do を記述し、子を中に書き、最後に　end を記述する
    resource :favorites, only: [:create, :destroy] #単数にするとコントローラのidがリクエストに含まれない
    resources :book_comments, only: [:create, :destroy] #　Bookモデルの投稿に関連したコメントなので、booksの下に記述する
  end

end