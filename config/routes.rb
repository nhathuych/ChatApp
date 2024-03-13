Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  devise_scope :user do
    get :users, to: "devise/sessions#new"
  end

  # resources :users, only: :show
  get 'user/:id', to: 'users#show', as: 'user'
  resources :rooms, only: [:index, :create]
end
