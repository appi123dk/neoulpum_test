class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
    	t.integer :revenue, default: 0
    	t.decimal :menu_cost, default: 0
    	t.decimal :profit, default: 0
    	t.integer :cash, default: 0
    	t.integer :cash_loss, default: 0
    	t.integer :etc_buy_cost, default: 0
    	t.integer :material_buy_cost, default: 0
    	t.integer :labor_cost, default: 0
    	t.integer :saving_point, default: 0
    	t.integer :pre_money, default: 0
        t.integer :end_money, default: 0
        t.integer :cash_buy, default: 0
    	t.date :account_date

      t.timestamps null: false
    end
  end
end
