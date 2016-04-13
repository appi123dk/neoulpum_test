class AddUnitPriceToMenus < ActiveRecord::Migration
  def change
  	add_column :menus, :unit_price, :decimal, default: 0.0
  end
end
