# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_one :billing_address, dependent: :destroy
  has_one :payment, dependent: :destroy
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :billing_address, :order_items, :payment, allow_destroy: true

  def total_price
    order_items.map { |item| item.price * item.amount }.sum
  end

  def formatted_created_at
    billing_address&.created_at&.strftime('%Y/%m/%d %H時%M分')
  end
end
