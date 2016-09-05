class AddEmployeeIdToMaterials < ActiveRecord::Migration
  def change
  	add_reference :materials, :employee, index: true
  end
end
