Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  get 'people', to: 'relationships#index'

  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :videos, only: [:show] do
    collection do
      post :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
end
