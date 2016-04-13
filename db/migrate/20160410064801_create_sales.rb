class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
    	t.references :menu, index: true, foreign_key: true
    	t.integer :menu_sales, default:0
    	t.date :date_sales
      t.timestamps null: false
    end
  end
end
