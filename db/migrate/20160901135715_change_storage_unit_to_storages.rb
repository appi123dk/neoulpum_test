class ChangeStorageUnitToStorages < ActiveRecord::Migration
  def change
  	change_column :storages, :storage_unit, :decimal, :precision => 6, :scale => 2
  end
end
