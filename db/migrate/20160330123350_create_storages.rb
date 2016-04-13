class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
    	t.date :storage_date
    	t.integer :storage_unit
    	t.references :material, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
