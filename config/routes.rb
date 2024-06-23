# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  resources 'items'
  resources 'orders'
  resource :cart, only: [:show]

  root 'items#index'

  resources :carts do
    collection do
      post :empty
    end
  end

  scope :admin do
    resources :items
  end

  post 'add_item_to_cart', to: 'carts#add_item', as: 'add_item_to_cart'
end
