class Order < ApplicationRecord
  belongs_to :user
  has_one :billing_address
  has_one :payment
  has_many :order_items
  accepts_nested_attributes_for :billing_address, :order_items, :payment, allow_destroy: true
end
