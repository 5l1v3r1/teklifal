Rails.application.routes.draw do
  resources :announcements do
    resources :offers, except: [:index, :new]
  end
  get 'home/index'
  root 'home#index'
end
