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
    resources :books do
      resources :comments, module: :books
    end

    resources :users, only: [:show] do
      member do
        get :following, :followers
      end
    end
    resources :friendships, only: [:index, :create, :destroy]
    resources :reports do
      resources :comments, module: :reports
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
