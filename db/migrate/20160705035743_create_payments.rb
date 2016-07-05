class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.date :buy_date
    	t.integer :category    # 1. 시설구매  2. 비품구매  3. 지기지원비
    	t.string :buy_content  # 무엇에 사용했는가
    	t.integer :price       #가격
      t.timestamps null: false
    end
  end
end
