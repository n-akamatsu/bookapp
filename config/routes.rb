Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  post "likes/:micropost_id/create" => "likes#create"
  post "likes/:micropost_id/destroy" => "likes#destroy"
  get "static_pages/follow_page" => "static_pages#follow_page"
  get 'auth/:provider/callback', to: 'sessions#create'

  root 'static_pages#home'
  get    '/home', to: 'static_pages#home'
  get    '/about', to: 'static_pages#about'
  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :mypage
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :myposts,             only: [:create, :destroy, :edit]
  resources :relationships,       only: [:create, :destroy]
end
