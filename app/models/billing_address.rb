# frozen_string_literal: true

class BillingAddress < ApplicationRecord
  belongs_to :order

  # バリデーション除外リスト
  EXCLUDED_ATTRIBUTES = %w[id address2 created_at updated_at order_id].freeze

  (attribute_names - EXCLUDED_ATTRIBUTES).each do |attr_name|
    validates attr_name, presence: true
  end
end
