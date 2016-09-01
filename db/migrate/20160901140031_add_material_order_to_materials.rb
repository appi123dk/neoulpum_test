class AddMaterialOrderToMaterials < ActiveRecord::Migration
  def change
  	add_column :materials, :material_order, :integer, default: 999
  end
end
