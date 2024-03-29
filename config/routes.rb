Rails.application.routes.draw do
  # 顧客用
  # URL　/customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords],  controllers: {
    sessions: "admin/sessions"
  }
  
  # moduleはURLに、今回でいうとpublicをつけないようにできる。
  scope module: :public do
    #get'/'=>'public/homes#top'
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get "/customers/unsubscribe"=>"customers#unsubscribe"
    patch "/customers/withdrawal"=>"customers#withdrawal"
    #resources :の後にはテーブル名を記載。そのあとにonlyオプションでアクション名を記述。
    #注意　resourcesを使った場合にうまくアクションを認識できない場合がある。今回だとordersコントローラーが
    # 例でresourceにordersコントローラーを入れてしまうとなぜかshowアクションとしてconfirmationアクション認識されてしまうため、
    # そういった場合にはresourceから外して1つずつurlを設定していくしかない。下記のordersのurlのように。
    # 注意　resourcesで作ったルートに関してはurlに必ず/:idと入ってしまい、エラーの原因になりやすいため注意が必要。
    resources :posts, only: [:new, :create, :index, :show, :destroy, :update, :edit] do
      resources :post_comments, only: [:create, :destroy]
      resources :rts, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    #resources :rts, only: [:create, :destroy]
    resources :customers, only: [:index, :show, :edit] do
      member do
        #フォロー、フォロワー
        get :follows, :followers
        
        #いいね一覧
        get :liked_posts
        patch :update
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :notifications, only: [:index] do
    end
     # URLを自分で決めたものにカスタムするには、HTTPメソッド "任意のURL"=>"コントローラー名＃アクション名"　の形式の記述で変更できる。
     # またルーティングを各順番にも気を付ける（上から順番に読まれる）。
     get '/search', to: 'searchs#search'
     get "/genre/genre_search" => "genres#genre_search"
     get "/genre/search" => "searchs#genre_search"
     get '/timeline', to: 'timelines#index', as: 'timeline'
     delete "/notifications"=>"notifications#destroy"
  end
  
  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
    end
    resources :customers, only: [:edit, :index, :show, :update] do
    end
    resources :sessions, only: [:new, :index, :show, :edit, :create, :update] do
    end
    resources :genres, only: [:index, :create, :edit, :update] do
    end
    root to: 'homes#top'
  end
  
  # root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
