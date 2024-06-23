class ChangeExpirationDateToBeStringInPayments < ActiveRecord::Migration[7.0]
  def change
    change_column :payments, :expiration_date, :string
  end
end
