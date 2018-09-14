require "sidekiq/web"

Rails.application.routes.draw do
  get "/pages/*id" => 'pages#show', as: :page, format: false

  resources :user, path: "my", only: [] do
    collection do
      get 'offers'
      get 'announcements'
      resource :subscriber, only: [:new, :create, :edit, :update, :destroy], controller: :subscriber
      resources :subscriptions, except: :index do
        get :index, on: :collection, as: :my
      end
    end
  end


  get "subscriptions" => "subscriptions#index"
  resources :subscribers, only: [:index], controller: :subscriber
  
  authenticate :user, lambda { |u| u.manager? } do
    mount Sidekiq::Web => 'administration/sidekiq'
  end

  resources :car_announcements, except: [:show]
  resources :plain_announcements, except: [:show]
  resources :household_appliances_announcements, except: [:show]
  resources :car_rental_announcements, except: [:show]
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  resources :announcements do
    put :expire, on: :member
    resources :offers, except: :index

    # Anasayfadaki formdan gelen verileri ContentsController'da
    # alabilmek icin get ve post eklendi
    match 'car' => "car_announcements#new", on: :new, via: [:get, :post]
    match 'car_rental' => "car_rental_announcements#new", on: :new, via: [:get, :post]
    match 'household_appliances' => "household_appliances_announcements#new", on: :new, via: [:get, :post]
    get 'plain', on: :new, to: "plain_announcements#new"
  end

  resources :offers, only: :index
  
  get 'home/index'
  get 'home/pro'
  root 'home#index'

  namespace :administration do
    get "/" => "base#show"
    resources :announcements, only: [:index]
    resources :offers
    resources :users do
      resources :subscriptions, shallow: true
    end
    resources :unowned_users, only: [:update, :create], controller: :users
    resources :subscribers, only: [:index]
    resources :subscriptions, only: [:index]
    resources :car_announcement_subscriptions, only: [:index]
  end
end
