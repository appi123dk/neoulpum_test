class AddRestingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :resting, :boolean, default: false
  end
end
