# frozen_string_literal: true

class AddDiscardedAtToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :discarded_at, :datetime, precision: 6
    add_index :items, :discarded_at
  end
end
