Rails.application.routes.draw do
  devise_for :users
  resources :announcements do
    resources :offers
  end
  get 'home/index'
  root 'home#index'
end
