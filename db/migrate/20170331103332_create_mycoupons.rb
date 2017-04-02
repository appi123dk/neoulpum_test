class CreateMycoupons < ActiveRecord::Migration
  def change
    create_table :mycoupons do |t|
    	t.belongs_to :coupon, index: true            # 쿠폰 DB 연동
    	t.belongs_to :user, index: true              # 유저 DB 연동
    	t.integer :unit, default: 0									 # 사용한 쿠폰 갯수
      t.timestamps null: false
    end
  end
end
