# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def total_price
    # 0円も表示するため
    cart_items.inject(0) { |sum, cart_item| sum + (cart_item.item.price * cart_item.amount) }
  end

  def total_amount
    cart_items.sum(:amount)
  end
end
