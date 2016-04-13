class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
    	t.references :material, index: true, foreign_key: true
    	t.references :menu, index: true, foreign_key: true
    	t.decimal :material_unit
      t.timestamps null: false
    end
  end
end
