class CreateDeliveryGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_goals do |t|
      t.integer :member_id
      t.string  :postcode
      t.string  :address
      t.string  :name
      t.timestamps
    end
  end
end
