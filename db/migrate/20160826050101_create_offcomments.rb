class CreateOffcomments < ActiveRecord::Migration
  def change
    create_table :offcomments do |t|
    	t.string :user_name
    	t.string :user_number
    	t.string :user_content
      t.timestamps null: false
    end
  end
end
