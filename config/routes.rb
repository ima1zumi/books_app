# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)" do
    root to: "books#index"
    devise_for :users
    resources :books
    resources :users, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
