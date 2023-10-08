# frozen_string_literal: true

class RenameAddress2InBillingAddresses < ActiveRecord::Migration[7.0]
  def change
    rename_column :billing_addresses, :address_2, :address2
  end
end
