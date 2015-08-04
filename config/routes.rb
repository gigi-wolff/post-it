PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  #create a named route called register automatically
  #CRUD is not applicable so resource is not an appropriate choice,
  #instead manually build routes 
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

#When we use resources routes, we are mapping the browser 
#requests (HTTP verbs and URLs) to the controller actions 
#of our app

  # routes are mapped to: controller actions (Order of declaration matters)
  # get '/posts', to: 'posts#index', as: 'posts_path'
  # get '/posts/:id', to: 'posts#show', as 'post_path(object)'
  # get '/posts/:id/edit', to: 'posts#edit', as 'edit_post_path(object)'
  # get '/posts/new', to: 'posts#new', as 'new_post_path'
  # post '/posts', to: 'posts#create'
  # patch '/posts/:id', to: 'posts#update'
  # delete '/posts/:id', to: 'posts#destroy'

  # resource routing maps routes to controller actions replacing code above
  # with a single line of code:   "resources :posts"

  #for each post, you have the ability to create a comment; comments are nested
  #in each post
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update] 

end
