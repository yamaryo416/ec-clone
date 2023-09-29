# frozen_string_literal: true

require 'discard'

class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { in: 0.. }
  validates :stock, numericality: { in: 0.. }
  include Discard::Model
  default_scope -> { kept }
  has_one_attached :image
end
