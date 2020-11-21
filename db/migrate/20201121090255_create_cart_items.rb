class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :member_id
      t.integer :product_id
      t.integer :amount
      t.timestamps
    end
  end
end
