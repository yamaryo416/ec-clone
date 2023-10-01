# frozen_string_literal: true

require 'discard'

class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { in: 0.. }
  validates :stock, numericality: { in: 0.. }
  include Discard::Model
  default_scope -> { kept }
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  def enough_stock?(amount)
    stock >= amount
  end
end
