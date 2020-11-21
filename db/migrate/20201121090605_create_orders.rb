class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :member_id
      t.string :postcode
      t.string :address
      t.string :name
      t.integer :freight
      t.integer :total_payment
      t.integer :payment_method, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
