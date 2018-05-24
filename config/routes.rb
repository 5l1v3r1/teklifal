Rails.application.routes.draw do
  devise_for :users
  resources :announcements do
    put :expire, on: :member
    resources :offers, except: :index
  end

  resources :offers, only: :index
  
  get 'home/index'
  root 'home#index'
end
