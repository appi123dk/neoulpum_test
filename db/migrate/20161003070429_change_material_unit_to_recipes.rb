class ChangeMaterialUnitToRecipes < ActiveRecord::Migration
  def change
  	change_column :recipes, :material_unit, :decimal, :precision => 6, :scale => 2
  end
end
