class EmployeesController < ApplicationController
	before_action :require_user
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
  	employee.employee_image = params[:employee_image]
  	employee.image_url = params[:image_url]
  	employee.save

  	redirect_to '/employees/employee_new'
	end

	def employee_edit
		@employee = Employee.find(params[:id])
	end

	def employee_update
		employee = Employee.find(params[:id])
		employee.student_number  = params[:student_number]
  	employee.employee_name   = params[:employee_name]
  	employee.employee_phone  = params[:employee_phone]
  	employee.employee_email  = params[:employee_email]
 		employee.employee_birth  = params[:employee_birth]
  	employee.cardinal_number = params[:cardinal_number]
  	# employee.employee_image = params[:employee_image]
  	employee.image_url = params[:image_url]
  	employee.save

  	redirect_to '/employees/index'
		
	end

	def semester
		## 학기정보 입력
		check = Semester.where('year = ? AND semester = ?', params[:year], params[:semester]).take
		if check.nil?
			semester          = Semester.new
			semester.year     = params[:year]
			semester.semester = params[:semester]
			semester.save
		end
		redirect_to '/employees/duty'
	end

	def semester_team
		## 학기별 늘품지기화면
		@semester_id = params[:id]
		@semester = Semester.find(@semester_id)
		@employees = Employee.all
		@teams = Team.where("semester_id = ?", @semester_id)
		@president = @teams.where("job = ?", "사장").take
		@vice_president = @teams.where("job = ?", "부사장").take
		@team_leaders = @teams.where("job = ?", "팀장").order("team")
		@team_partners = @teams.where("job = ?", "팀원").order("team")
		@team_elements = ["교육팀","구매팀","기획팀","마케팅팀","인사팀","회계팀"]

	end

	def team_create
		## 학기별 늘품지기 등록
		team = Team.new
		team.team = params[:team]
		team.job = params[:job]
		team.employee_id = params[:employee]
		team.semester_id = params[:semester_id]
		team.save

		redirect_to "/employees/semester_team/#{params[:semester_id]}"
		
	end

	def delete
		Team.where("employee_id = ?", params[:id]).destroy_all
		redirect_to :back
	end
end
