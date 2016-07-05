class ChangeUnitPriceToMenus < ActiveRecord::Migration
  def change
  	change_column :menus, :unit_price, :decimal, default: 0.0, :precision => 6, :scale => 2
  end
end
