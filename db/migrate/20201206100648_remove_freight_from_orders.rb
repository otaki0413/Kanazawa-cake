class RemoveFreightFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :freight, :integer
  end
end
