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
  
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get "/customers/unsubscribe"=>"customers#unsubscribe"
    patch "/customers/withdrawal"=>"customers#withdrawal"
    resources :posts, only: [:new, :create, :index, :show, :destroy, :update, :edit] do
      resources :post_comments, only: [:create, :destroy]
      resources :rts, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
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
