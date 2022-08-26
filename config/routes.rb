# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'

  resources :login
  get '/login', to: 'login#index'
  get '/logout', to: 'login#logout'

  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
