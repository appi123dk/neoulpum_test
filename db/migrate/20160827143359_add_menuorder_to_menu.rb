class AddMenuorderToMenu < ActiveRecord::Migration
  def change
  	add_column :menus, :menu_order, :integer, default: 999
  end
end
