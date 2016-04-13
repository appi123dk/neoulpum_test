class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_email
    	t.string :user_name
      t.string :password
    	t.string :user_number
    	t.string :user_major
    	t.string :user_job
    	t.integer :user_money, default: 0
      t.boolean :admin, default: false
      t.timestamps null: false
    end
  end
end
