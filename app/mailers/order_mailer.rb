# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def send_order_success_email
    @order = params[:order]
    mail(to: @order.billing_address.email, subject: I18n.t('mail.subject'))
  end
end
