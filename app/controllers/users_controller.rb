class UsersController < ApplicationController

	def create
		# 직업 : 1 = 학생, 2 = 교직원, 3 = 기타
		# 전공 : 1 = 호텔관광대학, 2 = ....
		@user = User.new
		@user.user_email = params[:user_email]
		@user.user_name = params[:user_name]
		@user.password = params[:password]
		@user.user_number = params[:user_number]
		@user.user_major = params[:user_major]
		@user.user_job = params[:user_job]
		if @user.save
			session[:user_id] = User.last.id
			redirect_to '/'
		else
			redirect_to '/'
		end
	end

	def login_process
		user = User.where('user_email = ? AND password = ?',params[:user_email], params[:password]).take
		if user.nil?
			redirect_to '/'
		else 
			session[:user_id] = user.id
			redirect_to '/'
		end
	end

	def logout
		reset_session
		redirect_to '/'
		
	end

	def index
		@users = User.all
		unless params[:user_id].nil?
			@f_user = User.find(params[:user_id])
			render :json => @f_user
		end
	end

	def money
		account = Account.last
		account.saving_point += params[:user_money].to_i
		account.save
		user = User.find(params[:id])
		user.user_money += params[:user_money].to_i
		user.save
		redirect_to :back
	end

end
