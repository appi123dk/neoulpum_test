class LandingController < ApplicationController
  def index
  	unless session[:user_id].nil?
  		@user = User.find(session[:user_id])
      # @visit_count = OrdersUser.where(:created_at => 1.year.ago..Date.today()+1).where('user_id = ?', @user.id).count
  		@visit_count = @user.count
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

      @user_order = @user.orders.where('order_confirm = ?', false)
      @first_order = Order.where('order_confirm = ?', false).first

      @mycoupons = @user.mycoupons
  	end
    @year = Date.today().year()
    if (2..7).include?(Date.today().month())
      @semester = 1 
    else
      @semester = 2
    end
    jigi = Semester.where('year = ? AND semester = ?', @year.to_s, @semester.to_s).take

    unless jigi.nil?
      @teams = jigi.teams
    end
    render :layout => "empty"
  end

end