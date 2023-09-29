# frozen_string_literal: true

class Item < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string 'name', presence: true
      t.text 'description'
      t.integer 'price', presence: true, numericality: true, default: 0
      t.integer 'stock', presence: true, numericality: true, default: 0
      t.timestamps
    end
  end
end
