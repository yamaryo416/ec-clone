# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'test@ymail.ne.jp'
  layout 'mailer'
end
