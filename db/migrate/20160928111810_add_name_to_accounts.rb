class AddNameToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :employee_name, :string
  end
end
