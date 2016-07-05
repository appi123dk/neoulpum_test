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
    last_day = Date.civil(year,month,-1).day
    month_account = Account.where('extract(month from account_date) = ?', month)
    
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
  end

end
