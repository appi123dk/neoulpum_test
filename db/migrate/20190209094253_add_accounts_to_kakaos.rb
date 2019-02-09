class AddAccountsToKakaos < ActiveRecord::Migration
  def change
  	add_column :accounts, :kakao_money, :integer, default: 0
  end
end
