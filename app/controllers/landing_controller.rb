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
			@user_level = '일반'
			if @user.user_rate == 1
				@user_level = '골드'
			elsif @user.user_rate == 2
				@user_level = 'VIP'
			elsif @user.user_rate >= 3
				@user_level = 'VVIP'
			end

  	end
  	@employees = Employee.last(24)
    render :layout => "empty"
  end

end