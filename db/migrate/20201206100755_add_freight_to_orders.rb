class AddFreightToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :freight, :integer, default: 800
  end
end
