require "sidekiq/web"

Rails.application.routes.draw do
  resources :notes
  # https://medium.com/@mikekitson/redirecting-to-a-bare-domain-in-rails-5-7fe533df225f
  match '(*any)', to: redirect(subdomain: ''), via: :all, constraints: {subdomain: 'www'}

  authenticate :user, lambda { |u| u.manager? } do
    mount Logster::Web => "/logs"
    mount Sidekiq::Web => 'administration/sidekiq'
  end

  get "/pages/*id" => 'pages#show', as: :page, format: false

  concern :noteable do
    resources :notes
  end

  resources :account, only: [] do
    get :get_your_account, on: :member
    get :cancel_account, on: :member
    put :update_account, on: :member
  end

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
    resources :announcements, only: [:index, :show, :destroy, :edit] do
      get :email, on: :member
      resources :emails, only: [:new, :create]
    end
    resources :offers
    resources :users, concerns: :noteable do
      resources :subscriptions, shallow: true
    end
    resources :unowned_users, only: [:update, :create], controller: :users
    resources :subscribers, only: [:index] do
      get :ann_subscribers, on: :collection
    end
    resources :subscriptions, only: [:index]
    resources :car_announcement_subscriptions, only: [:index]
    resource :notification, only: [] do
      collection do
        post :sms
        post :email
      end
    end
  end
end
