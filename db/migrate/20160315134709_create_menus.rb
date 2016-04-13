class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
    		t.string :menu_title
    		t.string :menu_symbol
    		t.string :menu_degree
    		t.integer :menu_price
    		t.integer :menu_category_id
      t.timestamps null: false
    end
  end
end
