# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items :except => [:edit, :update, :destroy]
end
