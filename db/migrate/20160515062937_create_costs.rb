class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
    	t.references :material, foreign_key: true
    	t.references :employee, index: true, foreign_key: true
    	t.string :buy_content
    	t.integer :buy_price
    	t.date :buy_date
    	t.boolean :buy_pament, default: false
      t.timestamps null: false
    end
  end
end
