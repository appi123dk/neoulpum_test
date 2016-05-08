class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :cs_content
    	t.boolean :read_confirm, default: false
    	t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
