class AddSizeToMenus < ActiveRecord::Migration
  def change
  	add_column :menus, :menu_size, :integer, default: 1
  	add_column :menus, :menu_promo, :boolean, default: false
  end
end
