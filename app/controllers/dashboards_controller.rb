class DashboardsController < ApplicationController
  before_action :require_user
  def dashboard_1
  end

  def dashboard_2
    
  end

  def dashboard_3
    @extra_class = "sidebar-content"
  end

  def dashboard_4
    render :layout => "layout_2"
  end

  def dashboard_4_1
  end

  def dashboard_5
  end

  def neulpum_dashboard
    # 오늘의 연, 월을 구하고 마지막 일 구하는 함수
    year = DateTime.now.year
    month = DateTime.now.month
    today = DateTime.now.day
    last_day = Date.civil(year,month,-1).day
    month_account = Account.where('extract(month from account_date) = ? AND extract(year from account_date) = ?', month, year)
    today_order = Detail.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    
    #100일단위로 수정
    @total_rev = 0
    @x_axis = []
    @y_axis = []
    rev_date = Date.today-50..Date.today
    rev_date.each do |date|
      @x_axis << date.day.to_s + '일'
      rev = Account.where('account_date = ?', date).take
      if rev.nil?
        @y_axis << 0
      else
        @y_axis << rev.revenue 
        @total_rev += rev.revenue
      end
    end

    # 그래프에 날릴 매출값 함수
    # @total_rev = 0
    # @x_axis = []
    # @y_axis = []
    # 1.upto(last_day) do |day|
    #   @x_axis << day.to_s + '일'
    #   rev = month_account.where('extract(day from account_date) = ?', day).take
    #   if rev.nil?
    #     @y_axis << 0
    #   else
    #     @y_axis << rev.revenue 
    #     @total_rev += rev.revenue
    #   end

    # 일매출 그래프 매출값 함수
    @day_rev = 0
    @x_axis2 = []
    @y_axis2 = []
    0.upto(23) do |hour|
      rev = 0
      @x_axis2 << hour.to_s + '시'
      (hour + 15) <= 24 ? hour = hour+15 : hour = hour-9
      hour_order = today_order.where('hour(created_at) = ?', hour)
      if hour_order.nil?
        @y_axis2 << 0
      else
        hour_order.each do |order|
          rev += order.menu.menu_price * order.order_unit
        end
        @y_axis2 << rev
        @day_rev += rev
      end
    end

  end

  def marketing_dashboard
    # 고객정보 모음
    @users = User.where.not(user_email: "admin@neoulpum.com")
    @grade = Hash.new
    @grade = { "0": "콩알", '1': '새싹', '2': '떡잎', '3': '킹콩'}
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
      '16': '자율전공학부'
    }
    user_count = @users.count
    @user_count = @users.count

    # 데이터산출
    # 늘품지기 혜택금
    @employee_discount = Order.where('use_point = ?', 500).sum('use_point')

    # 총 적립금
    admin_id = User.where('user_email = ?', 'admin@neoulpum.com').take.id
    not_admin_order = OrdersUser.where('user_id != ?', admin_id)
    @use_point = []
    not_admin_order.each do |order|
      @use_point << Order.find(order.order_id).use_point
    end
    @use_point = @use_point - [0]
    @save_point = @users.sum("user_money")
    @total_point = @use_point.sum + @save_point
    @avg_save_point = @save_point/user_count
    @avg_use_point = @use_point.sum/user_count

    # 방문횟수
    @visit_count = [] 
    @users.each do |user|
      @visit_count << OrdersUser.where('user_id = ?', user.id).count
    end
    @visit_count.sort!
    @q1_visit_count = @visit_count[user_count/4]
    @mid_visit_count = @visit_count[user_count/2]
    @q3_visit_count = @visit_count[user_count*3/4]

    # 학과인원 추출
    @major_counts = Hash.new 0
    majors = @users.pluck(:user_major)
    majors.each do |major|
      @major_counts[major] += 1
    end

  end

  def day_revenue
    today_order = Detail.where(created_at: params[:rev_date].to_date.beginning_of_day..params[:rev_date].to_date.end_of_day)
    @day_rev = 0
    @x_axis2 = []
    @y_axis2 = []
    0.upto(23) do |hour|
      rev = 0
      @x_axis2 << hour.to_s + '시'
      (hour + 15) <= 24 ? hour = hour+15 : hour = hour-9
      hour_order = today_order.where('hour(created_at) = ?', hour)
      if hour_order.nil?
        @y_axis2 << 0
      else
        hour_order.each do |order|
          rev += order.menu.menu_price * order.order_unit
        end
        @y_axis2 << rev
        @day_rev += rev
      end
    end

    render json:  {x_axis: @x_axis2, 
                   y_axis: @y_axis2,
                   day_rev: @day_rev }
  end

end
