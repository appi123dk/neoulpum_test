class AddMaterialsToOrderDates < ActiveRecord::Migration
  def change
  	add_column :materials, :order_date, :date
  end
end
