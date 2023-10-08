# frozen_string_literal: true

class RemovePaymentIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    # Order テーブルから payment_id カラムを削除
    remove_column :orders, :payment_id, :integer
  end
end
