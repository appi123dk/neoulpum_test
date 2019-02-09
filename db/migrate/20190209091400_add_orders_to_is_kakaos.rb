class AddOrdersToIsKakaos < ActiveRecord::Migration
  def change
  	add_column :orders, :is_kakao, :boolean, default: false
  end
end
