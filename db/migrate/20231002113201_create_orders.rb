class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :billing_address, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
