class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
    	t.references :menu, index: true, foreign_key: true
    	t.references :order, index: true, foreign_key: true
    	t.integer :order_unit
      t.timestamps null: false
    end
  end
end
