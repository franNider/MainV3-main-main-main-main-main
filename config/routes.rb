Rails.application.routes.draw do
  resources :chequeos
  resources :vacunas
  get 'inicio/index'
  get 'turnos/index'
  get 'authentication/sessions/new'
  resources :turnos
  resources :main
  resource :password, only: [:edit, :update]
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:show, :new, :create, :edit, :update]
    resources :sessions, only: [:new, :create]
  end

  resources :dogs do
    get 'verFichaMedica', on: :member
  end
  patch '/dogs/:id/edit', to: 'dogs#update'
  get '/dogs/:id/edit', to: 'dogs#edit'
  

  get 'password', to: 'passwords#edit'
  patch 'password', to: 'passwords#update'
  patch '/users/:id', to: 'users#update'
  get '/users/:id/edit', to: 'users#edit'
  get '/users/:id', to: 'users#show'
  get 'logout', to: 'authentication/sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "inicio#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  

  # Defines the root path route ("/")
  # root "posts#index"

  
end

