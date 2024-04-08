Rails.application.routes.draw do
  root "home#index"

  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # resources :users, only: :show
  get 'user/:id', to: 'users#show', as: 'user'
  resources :rooms, only: [:index, :create, :show] do
    resources :messages, only: [:create], module: :rooms
  end
end
