# frozen_string_literal: true

Rails.application.routes.draw do
  resources 'items'

  scope :admin do
    resources :items
  end
end
