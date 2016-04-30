class AccountsController < ApplicationController
	before_action :require_user
	def account_open
		account = Account.new
		account.pre_money = params[:pre_money]
		account.account_date = Date.strptime(params[:date],'%m/%d/%Y')
		account.save
		redirect_to '/orders/order_index'
	end

	def account_new
		@saving_point = Account.last.saving_point
		@pre_money = Account.where('account_date=?',Date.today()).take
		@etc = Account.last.cash_buy
		@revenue = 0
		@point = 0
		orders = Detail.where(created_at: Time.now.midnight..(Time.now.midnight + 1.day))
		big_orders = Order.where(created_at: Time.now.midnight..(Time.now.midnight + 1.day))
		orders.each do |order|
			menu = Menu.find(order.menu_id)
			@revenue += order.order_unit * menu.menu_price
		end
		big_orders.each do |order|
			unless order.use_point.nil?
				@point += order.use_point 
			end
		end
		unless @pre_money.nil?
			@saving = @revenue + @pre_money.pre_money - @etc - @point + @saving_point
		end
	end

	def account_update
		# 정산가격
		@saving_point = Account.last.saving_point
		@revenue = 0
		@menu_cost = 0
		orders = Detail.where(created_at: Time.now.midnight..(Time.now.midnight + 1.day))
		orders.each do |order|
			menu = Menu.find(order.menu_id)
			@revenue += order.order_unit * menu.menu_price
			@menu_cost += order.order_unit * menu.unit_price
		end

		# Sales 개수
		menus = Menu.all
		sales = Sale.where('date_sales=?',Date.today()).take
		menus.each do |menu|
			if sales.nil?
				sale = Sale.new
				sale.menu_id = menu.id
				if orders.where('menu_id=?', menu.id).nil?
					sale.menu_sales = 0
				else
					sale.menu_sales = orders.where('menu_id=?', menu.id).count * orders.where('menu_id=?', menu.id).sum(:order_unit)
				end
				sale.date_sales = Date.today().to_formatted_s(:db)
				sale.save
			else
				if sales.where('menu_id=?', menu.id).nil?
					sale = Sale.new
					sale.menu_id = menu.id
					if orders.where('menu_id=?', menu.id).nil?
						sale.menu_sales = 0
					else
						sale.menu_sales = orders.where('menu_id=?', menu.id).count * orders.where('menu_id=?', menu.id).sum(:order_unit)
					end
					sale.date_sales = Date.today().to_formatted_s(:db)
					sale.save
				else
					sale = sales.where('menu_id=?', menu.id).take
					sale.menu_sales = orders.where('menu_id=?', menu.id).count * orders.where('menu_id=?', menu.id).sum(:order_unit)
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
		account.save

		redirect_to '/accounts/account_index'

	end

	def account_index
		@accounts = Account.all
		@menus = Menu.all
	end

end
