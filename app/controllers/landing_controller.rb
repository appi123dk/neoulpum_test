class LandingController < ApplicationController
  def index
  	unless session[:user_id].nil?
  		@user = User.find(session[:user_id])
  		@visit_count = OrdersUser.where('user_id = ?', @user.id).count
  		order_menu_arr = []
  		@user.orders.each do |order|
  			order.details.each do |detail|
  				detail.order_unit.times do |i|
	  				order_menu_arr << detail.menu_id
	  			end
  			end
  		end
  		@counts = Hash.new 0
			order_menu_arr.each do |menu|
			  @counts[menu] += 1
			end
			@user_level = '콩알'
			if @user.user_rate == 1
				@user_level = '새싹'
			elsif @user.user_rate == 2
				@user_level = '떡잎'
			elsif @user.user_rate >= 3
				@user_level = '킹콩'
			end

  	end
    @year = Date.today().year()
    Date.today().month().in?(2..7) ? @semseter = 1 : @semester = 2
  	@teams = Semester.where('year = ? AND semester = ?', @year.to_s, @semester.to_s).take.teams
    render :layout => "empty"
  end

end