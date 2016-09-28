class AccountsController < ApplicationController
	before_action :require_user
	def account_open
		## 늘품 오픈 페이지
		account = Account.new
		account.pre_money = params[:pre_money]
		account.account_date = Date.strptime(params[:date],'%m/%d/%Y')
		account.save
		redirect_to '/orders/order_index'
	end

	def account_new
		## 마감페이지
		@saving_point = Account.last.saving_point
		@pre_money = Account.where('account_date=?',Date.today()).take
		@etc = Account.last.cash_buy
		@point = 0

		#오늘의 주문과 수입
		orders = Detail.today_orders
		@revenue = Account.today_revenue orders

		# 유저 포인트 사용내역
		big_orders = Order.where(created_at: Time.now.midnight..(Time.now.midnight + 1.day))
		big_orders.each do |order|
			unless order.use_point.nil?
				@point += order.use_point 
			end
		end

		# 통장잔고
		unless @pre_money.nil?
			@saving = @revenue + @pre_money.pre_money - @etc - @point + @saving_point
		end
	end

	def account_update
		## 마감시 계좌정보 최신
		# 적립금 추가액
		@saving_point = Account.last.saving_point

		#오늘의 주문과 수입/비용
		orders = Detail.today_orders
		@revenue = Account.today_revenue orders
		@menu_cost = Account.today_cost orders
		@point = 0

		# 유저 포인트 사용내역
		big_orders = Order.where(created_at: Time.now.midnight..(Time.now.midnight + 1.day))
		big_orders.each do |order|
			unless order.use_point.nil?
				@point += order.use_point 
			end
		end

		# Sales 개수
		menus = Menu.all
		sales = Sale.where('date_sales=?',Date.today()).take
		sales2 = Sale.where('date_sales=?',Date.today())
		menus.each do |menu|
			#마감 전
			if sales.nil?
				sale = Sale.new
				sale.menu_id = menu.id
				if orders.where('menu_id=?', menu.id).take.nil?
					sale.menu_sales = 0
				else
					sale.menu_sales = orders.where('menu_id=?', menu.id).sum(:order_unit)
				end
				sale.date_sales = Date.today().to_formatted_s(:db)
				sale.save			
			#마감 후
			else
				if sales2.where('menu_id=?', menu.id).take.nil?
					sale = Sale.new
					sale.menu_id = menu.id
					if orders.where('menu_id=?', menu.id).take.nil?
						sale.menu_sales = 0
					else
						sale.menu_sales = orders.where('menu_id=?', menu.id).sum(:order_unit)
					end
					sale.date_sales = Date.today().to_formatted_s(:db)
					sale.save
				else
					sale = sales2.where('menu_id=?', menu.id).take
					sale.menu_sales = orders.where('menu_id=?', menu.id).sum(:order_unit)
					sale.save
				end
			end

		end

		# update
		account = Account.last
		account.revenue = @revenue
		account.cash = params[:cash_money].to_i
		account.cash_loss = params[:cash_loss].to_i
		account.saving_point = @saving_point
		account.end_money = params[:end_money].to_i
		account.menu_cost = @menu_cost
		account.profit = @revenue - @menu_cost
		account.use_point = @point
		account.employee_name = params[:employee_name]
		account.save

		redirect_to '/accounts/account_index'

	end

	def account_index
		@accounts = Account.all
		@menus = Menu.all
	end

	def cashbuy_create
		account = Account.last
		account.cash_buy += params[:cash_buy].to_i
		if account.cash_buy_content.nil?
			account.cash_buy_content = params[:cash_buy_content]
		else
			account.cash_buy_content += ", " + params[:cash_buy_content]
		end
		account.save

		redirect_to '/orders/order_index'
	end

end
