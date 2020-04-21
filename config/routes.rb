# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  scope "(:locale)" do
    root to: "books#index"
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations",
    }
    resources :books
    resources :users, only: [:show] do
      resources :user_follows, only: [:create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
