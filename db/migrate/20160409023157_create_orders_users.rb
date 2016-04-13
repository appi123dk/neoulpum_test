class CreateOrdersUsers < ActiveRecord::Migration
  def change
    create_table :orders_users do |t|
    	t.belongs_to :order, index: true
    	t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
