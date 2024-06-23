# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :name_on_card
      t.string :credit_card_number
      t.date :expiration_date
      t.integer :cvv

      t.timestamps
    end
  end
end
