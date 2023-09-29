class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def total_price
    cart_items.inject(0) { |sum, cart_item| sum + (cart_item.item.price * cart_item.amount) }
  end
end
