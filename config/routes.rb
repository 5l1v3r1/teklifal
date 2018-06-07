require "sidekiq/web"

Rails.application.routes.draw do

  get 'my/announcements', to: "user#announcements"
  get 'my/offers', to: "user#offers"
  authenticate :user, lambda { |u| u.manager? } do
    mount Sidekiq::Web => 'administration/sidekiq'
  end

  resources :car_announcements, except: [:show]
  resources :car_rental_announcements, except: [:show]
  devise_for :users

  resources :announcements do
    put :expire, on: :member
    resources :offers, except: :index
    get 'car', on: :new, to: "car_announcements#new"
    get 'plain', on: :new
    get 'car_rental', on: :new, to: "car_rental_announcements#new"
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
