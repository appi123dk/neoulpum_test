class AddScaleToMaterial < ActiveRecord::Migration
  def change
  	add_column :materials, :scale, :string
  end
end
