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
    
    # 그래프에 날릴 매출값 함수
    @total_rev = 0
    @x_axis = []
    @y_axis = []
    1.upto(last_day) do |day|
      @x_axis << day.to_s + '일'
      rev = month_account.where('extract(day from account_date) = ?', day).take
      if rev.nil?
        @y_axis << 0
      else
        @y_axis << rev.revenue 
        @total_rev += rev.revenue
      end

    end

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
          rev = order.menu.menu_price * order.order_unit
        end
        @y_axis2 << rev
        @day_rev += rev
      end
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
          rev = order.menu.menu_price * order.order_unit
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
