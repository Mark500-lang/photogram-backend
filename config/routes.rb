Rails.application.routes.draw do
  resources :likes
  #resources :followers
  #resources :posts
  resources :users
  #resources :comments

  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/loggedin", to: "users#loggedin"
  patch '/posts/:id/comments', to: 'posts#update_comments'


  
  

  root to: 'posts#index'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end

  #route for editing user profile
  resources :users, only: [:edit, :update]

  resources :users do
    member do
      post :follow
      delete :unfollow
      get :followers
      get :following
    end
  end
  
  resources :posts do
    resources :comments, only: [:create, :index, :update]
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
  
  
   get '/users/:username', to: 'users#show'

   # Fetch post information
   get '/posts/:id', to: 'posts#show'
 
   # Fetch likes for the post
   get '/posts/:id/likes', to: 'likes#index'
 
   # Fetch like count for the post
   get '/posts/:id/likes/count', to: 'likes#count'
 
  
  #  root to: 'posts#index'
  
   get '/signup', to: 'users#new'
   post '/signup', to: 'users#create'
   
  # resource :profile, only: [:edit, :update]
  # get '/profile/edit', to: 'profiles#edit', as: 'edit_profile'

  # # Update profile action
  # patch '/profile', to: 'profiles#update', as: 'update_profile'

   #added for login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  patch '/users/:id', to: 'users#update'

  resources :users, only: [:edit, :update]
 
end
