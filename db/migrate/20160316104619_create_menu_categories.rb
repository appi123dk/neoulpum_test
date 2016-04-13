class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|

    	t.string :category_code
    	t.string :category_title
    	
      t.timestamps null: false
    end
  end
end
