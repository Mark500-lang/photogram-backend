Rails.application.routes.draw do
  resources :likes
  #resources :followers
  #resources :posts
  # resources :users
  resources :comments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'posts#index'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments
  end

  resources :users do
    member do
      post :follow
      delete :unfollow
      get :followers
      get :following
    end
  end
  
  resources :comments, only: [:edit, :update]
  resources :posts do
    resources :comments, only: [:create, :index]
    resources :likes, only: [:create]
  end
  
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resources :likes, only: [:create]
  end
  
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  
  
end
