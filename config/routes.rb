Rails.application.routes.draw do
  resources :car_announcements, except: [:show]
  devise_for :users

  resources :announcements do
    put :expire, on: :member
    resources :offers, except: :index
    get 'car', on: :new, to: "car_announcements#new"
  end

  resources :offers, only: :index
  
  get 'home/index'
  get 'home/pro'
  root 'home#index'

  namespace :administration do
    get "/" => "base#show"
    resources :announcements, only: [:index]
    resources :offers, only: [:index]
    resources :users, only: [:index]
  end
end
