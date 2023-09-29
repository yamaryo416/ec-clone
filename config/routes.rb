# frozen_string_literal: true

Rails.application.routes.draw do
  resources 'items'
  resource :cart, only: [:show]

  scope :admin do
    resources :items
  end

  post 'add_item_to_cart', to: 'carts#add_item', as: 'add_item_to_cart'

end
