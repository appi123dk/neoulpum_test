class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
    	t.string :student_number
    	t.string :employee_name
    	t.string :employee_phone
    	t.string :employee_email
    	t.date :employee_birth
    	t.integer :cardinal_number
      t.string :employee_image
      t.timestamps null: false
    end
  end
end
