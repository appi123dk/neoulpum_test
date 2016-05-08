class EmployeesController < ApplicationController
	def index
		@employees = Employee.all
	end

	def duty
		@semesters = Semester.all.order("year DESC, semester DESC")
	end

	def employee_new
		
	end

	def employee_create
		employee                 = Employee.new
		employee.student_number  = params[:student_number]
  	employee.employee_name   = params[:employee_name]
  	employee.employee_phone  = params[:employee_phone]
  	employee.employee_email  = params[:employee_email]
 		employee.employee_birth  = params[:employee_birth]
  	employee.cardinal_number = params[:cardinal_number]
  	employee.save

  	redirect_to '/employees/employee_new'
	end

	def employee_edit
		
	end

	def semester
		check = Semester.where('year = ? AND semester = ?', params[:year], params[:semester]).take
		if check.nil?
			semester          = Semester.new
			semester.year     = params[:year]
			semester.semester = params[:semester]
			semester.save
		end
		redirect_to '/employees/duty'
	end
end
