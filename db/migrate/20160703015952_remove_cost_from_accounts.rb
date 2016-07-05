class RemoveCostFromAccounts < ActiveRecord::Migration
  def change
  	add_column :menus, :display, :boolean, default: true
  	remove_column :accounts, :etc_buy_cost, :integer
  	remove_column :accounts, :material_buy_cost, :integer
  	remove_column :accounts, :labor_cost, :integer
  end
end
