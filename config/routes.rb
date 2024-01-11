# frozen_string_literal: true

# here all the routes are present to reach the particular controller and its action
Rails.application.routes.draw do
  resources :posts, only: %i[index create]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'signup', to: 'users#create'
end
