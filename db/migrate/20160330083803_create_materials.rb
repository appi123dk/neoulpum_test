1class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|

    	t.string :material_name       # 재료명
    	t.string :material_buyer      # 구매처
    	t.string :material_url        # 구매처 주소
    	t.decimal :material_volume    # 재료 용량(500ml)
    	t.integer :material_unit      # 재료 구매 갯수 (한번 주문할 때 구매하는 개수)
    	t.integer :material_limit     # 재료를 구매해야하는 최소 갯수
    	t.integer :material_price     # 재료 가격
    	t.integer :material_shipping  # 주문 후 배송까지 걸리는 기간

      t.timestamps null: false
    end
  end
end
