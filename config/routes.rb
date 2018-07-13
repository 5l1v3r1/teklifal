require "sidekiq/web"

Rails.application.routes.draw do

  resources :user, path: "my", only: [] do
    collection do
      get 'offers'
      # get 'my/subscription', to: "user#subscription"
      get 'announcements'
      resource :subscriber, only: [:new, :create, :edit, :update, :destroy], controller: :subscriber
    end
  end
  
  authenticate :user, lambda { |u| u.manager? } do
    mount Sidekiq::Web => 'administration/sidekiq'
  end

  resources :car_announcements, except: [:show]
  resources :household_appliances_announcements, except: [:show]
  resources :car_rental_announcements, except: [:show]
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  resources :announcements do
    put :expire, on: :member
    resources :offers, except: :index
    match 'car' => "car_announcements#new", on: :new, via: [:get, :post]
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
