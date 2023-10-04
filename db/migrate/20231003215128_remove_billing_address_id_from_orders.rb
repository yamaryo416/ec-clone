class RemoveBillingAddressIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :billing_address_id, :integer
  end
end
