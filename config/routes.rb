# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show] do
        resources :subscriptions, only: [:index, :create, :update]
      end
    end
  end
end
