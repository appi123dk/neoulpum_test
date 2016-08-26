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
			count = OrdersUser.where('user_id = ?', user.id).count
			user.user_rate = count/15
			user.save
			redirect_to '/'
		end
	end

	def logout
		reset_session
		redirect_to '/'
		
	end

	def index
		if admin_user
			@users = User.all
			unless params[:user_id].nil?
				@f_user = User.find(params[:user_id])
				render :json => @f_user
			end
			@grade = Hash.new
			@grade = { "0": "일반", '1': '골드', '2': 'VIP', '3': 'VVIP'}
			@jobs = Hash.new
			@jobs = {'1': '학생', '2': '교직원', '3': '기'}
			@colleges = Hash.new
	    @colleges = {
	      '1': '문과대학',
	      '2': '법과대학',
	      '3': '정경대학',
	      '4': '경영대학',
	      '5': '호텔관광대학',
	      '6': '이과대학',
	      '7': '생활과학대학',
	      '8': '의과대학',
	      '9': '한의과대학',
	      '10': '치과대학',
	      '11': '약학대학',
	      '12': '간호과학대학',
	      '13': '음악대학',
	      '14': '미술대학',
	      '15': '무용학부',
	      '16': '자율전공학'
	    }
  	else
  		redirect_to '/'
  	end

	end

	def money
		if admin_user
			account = Account.last
			account.saving_point += params[:user_money].to_i
			account.save
			user = User.find(params[:id])
			user.user_money += params[:user_money].to_i
			user.save
			redirect_to :back
		else
			redirect_to '/'
		end
	end

	def cs_create
		comment = Comment.new
		comment.user_id = params[:user_id]
		comment.cs_content = params[:user_comment]
		comment.save
		redirect_to '/'
	end

	def offline_cs_create
		comment = Offcomment.new
		comment.user_name = params[:user_name]
		comment.user_number = params[:user_number]
		comment.user_content = params[:user_content]
		comment.save
		redirect_to '/users/user_cs'
	end

	def user_cs
		if admin_user
			if params[:is_checked].nil?
				@comments = Comment.paginate(:page => params[:page], :per_page => 10).reverse_order
			else
				@users = []
				if params[:is_checked] == 'true'
					@comments = Comment.where('read_confirm = ?', false).paginate(:page => params[:page], :per_page => 10).reverse_order
					@comments.each do |comment|
						@users << comment.user
					end
					render json:  {comments: @comments, 
	                       users: @users }
				else
					@comments = Comment.paginate(:page => params[:page], :per_page => 10).reverse_order
					@comments.each do |comment|
						@users << comment.user
					end
					render json:  {comments: @comments, 
	                       users: @users }
				end
			end
		else
			redirect_to '/'
		end
	end

	def cs_complete
		comment = Comment.find(params[:comment_id])
		comment.read_confirm = true
		comment.save
		redirect_to '/users/user_cs'
	end

	def check_email
		@email = User.where('user_email = ?', params[:user_email]).take.nil?
		render json: @email
	end

	def check_number
		@number = User.where('user_number = ?', params[:user_number]).take.nil?
		render json: @number
	end

	def user_rate
		users = User.all
		users.each do |user|
			count = OrdersUser.where('user_id = ?', user.id).count
			user.user_rate = count/15
			user.save
		end
		redirect_to '/users/index'
	end

	def total_cs
		@comments = Comment.all
		@offcomments = Offcomment.all
	end

	def find_user
		@user = User.where('user_email = ? AND password = ?', params[:user_email], params[:passward]).take
		render json: @user
	end

end
