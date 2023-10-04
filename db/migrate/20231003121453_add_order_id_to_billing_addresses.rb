class AddOrderIdToBillingAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :billing_addresses, :order, null: false, foreign_key: true
  end
end
