# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :order
  validates :name_on_card, presence: true
  validates :credit_card_number, length: { is: 16 }
  validates :expiration_date, format: { with: %r{\A\d{2}/\d{2}\z}, message: I18n.t('errors.format_yymm') }
  validates :cvv, length: { is: 3 }
  # カード情報の伏せ字化
  def masked_credit_card_number
    "**** **** **** #{credit_card_number[-4..]}"
  end
end
