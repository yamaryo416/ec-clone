class RemoveAmountFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :amount, :integer
  end
end
