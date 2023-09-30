# frozen_string_literal: true

class RemoveItemIdFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :item_id, :integer
  end
end
