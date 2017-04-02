class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
    	t.string :c_name      # 쿠폰명
    	t.string :content   # 쿠폰상세설명
    	t.integer :unit     # 쿠폰발행갯수
    	t.integer :price    # 할인금액
      t.timestamps null: false
    end
  end
end
