class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :order_number
    	t.integer :use_point
    	t.boolean :make_confirm, default: false
    	t.boolean :order_confirm, default: false
      t.timestamps null: false
    end
  end
end
