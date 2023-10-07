# frozen_string_literal: true

class AddOrderIdToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :order, null: true, foreign_key: true
  end
end
