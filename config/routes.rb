Rails.application.routes.draw do
  resources :likes
  #resources :followers
  #resources :posts
  resources :users
  resources :comments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/loggedin", to: "users#loggedin"

  post "/login", to: "sessions#login"
  delete "/logout", to: "sessions#logout"

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
  
   #added
   get '/users/:username', to: 'users#show'

   # Fetch post information
   get '/posts/:id', to: 'posts#show'
 
   # Fetch likes for the post
   get '/posts/:id/likes', to: 'likes#index'
 
   # Fetch like count for the post
   get '/posts/:id/likes/count', to: 'likes#count'
 
   # Comment component routes
   resources :comments, only: [:create, :update, :destroy]
  
   
end
