# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user, if: :admin_url
  after_action :authenticate_user, if: :only_admin_action

  UPDATE_SUCSESS_MSG = '投稿が更新されました。'
  UPDATE_ERROR_MSG = '投稿の更新が失敗しました。もう一度試してください。'

  private

  def admin_url
    @is_admin = request.fullpath.include?('/admin')
  end

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
end
