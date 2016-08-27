class AddDisplayToMaterial < ActiveRecord::Migration
  def change
  	add_column :materials, :display, :boolean, default: true
  end
end
