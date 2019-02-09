class AddMenusToIsOrders < ActiveRecord::Migration
  def change
  	add_column :materials, :is_order, :boolean, default: false
  end
end
