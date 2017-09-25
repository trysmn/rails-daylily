Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/dionysus', as: 'rails_admin'
  devise_for :users
  root to: 'events#home'

  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Attachinary::Engine => "/attachinary"

  require "sidekiq/web"

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
