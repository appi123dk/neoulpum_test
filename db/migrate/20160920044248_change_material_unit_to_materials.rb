class ChangeMaterialUnitToMaterials < ActiveRecord::Migration
  def change
  	change_column :materials, :material_limit, :decimal, :precision => 6, :scale => 2
  end
end
