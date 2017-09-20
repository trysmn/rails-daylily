Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/dionysus', as: 'rails_admin'
  devise_for :users
  root to: 'events#home'

  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
