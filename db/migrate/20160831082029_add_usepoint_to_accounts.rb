class AddUsepointToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :use_point, :integer
  	add_column :accounts, :cash_buy_content, :string
  end
end
