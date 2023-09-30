# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user, if: :set_is_admin
  before_action :set_is_admin
  after_action :authenticate_user, if: :only_admin_action

  # 管理者権限のみでの操作にURLを操作して遷移されるのを防ぐ
  def only_admin_action
    request.fullpath.include?('/new') ||
      request.fullpath.include?('/edit') ||
      request.fullpath.include?('/create') ||
      request.fullpath.include?('/update') ||
      request.fullpath.include?('/destroy')
  end

  def authenticate_user
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def current_or_create_cart
    if session[:cart_id]
      Cart.find(session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  def set_is_admin
    @is_admin = request.referer&.include?('/admin') || request.fullpath.include?('/admin') || params[:admin] == 'true'
  end
end
