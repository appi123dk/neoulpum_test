class OrdersController < ApplicationController
	before_action :require_user
	def order_index
		@promo_menus = Menu.where('display = ? AND menu_promo = ?', true, true).order("menu_order")
		@coffee_menus = Menu.where('display = ? AND menu_category_id = ?',true, 1).order("menu_order")
		@tea_menus = Menu.where('display = ? AND menu_category_id = ?',true, 2).order("menu_order")
		@drink_menus = Menu.where('display = ? AND menu_category_id = ?',true, 3).order("menu_order")
		@pre_money = Account.where('account_date=?',Date.today()).take
	end

	def user_point
		@user = User.find(params[:user_id])
		@user.user_money -= params[:user_point].to_i
		@user.save
		render :json => @user
	end

	def find_user
		employee = Employee.where('employee_phone = ?', params[:user_number].to_s).take
		if employee.nil?
			@user = User.where('user_number = ?', params[:user_number].to_s).take
			@employee = employee
		else
			@user = User.where('user_number = ?', "0").take
			@employee = employee
		end

		render json: {employee: @employee, users: @user }
	end

	def order_create
		order = Order.new
		order.order_number = params[:order_number]
		order.use_point = params[:use_point]
		order.save

		last_order = Order.last.id
		point = 0
		0.upto(params[:menu_id].length - 1) do |index|
			detail = Detail.new
			detail.menu_id = params[:menu_id][index]
			detail.order_id = last_order
			detail.order_unit = params[:order_unit][index]
			detail.save
			menu = Menu.find(params[:menu_id][index])
			point += menu.menu_price * params[:order_unit][index].to_i
		end

		# 적립금 함수
		unless params[:user_id].nil?
			OrdersUser.create(order_id: last_order, user_id: params[:user_id])
			user = User.find(params[:user_id])
			user.user_money += point/10
			user.save
		end

		redirect_to '/orders/order_index'
	end

	def order_manage
		@pre_money = Account.where('account_date=?',Date.today()).take
		@orders = Order.where('make_confirm = ?', false)
		@shot = 0
		@make_orders = Order.where('order_confirm = ? AND make_confirm = ?', false, true)
	end

	def make_confirm
		order = Order.find(params[:id])
		order.make_confirm = true
		order.save

		redirect_to '/orders/order_manage'
	end

	def order_confirm
		order = Order.find(params[:id])
		order.order_confirm = true
		order.save

		redirect_to '/orders/order_manage'
	end

	def order_open
		@end_money = Account.where('end_money != ?', 0).last.end_money
	end

	def order_list
		@orders = Order.where('updated_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
	end

	def order_delete
		order = Order.find(params[:id])
		order.destroy

		redirect_to '/orders/order_list'
	end

	def order_cancle
		order = Order.find(params[:id])
		order.make_confirm = false
		order.save

		redirect_to '/orders/order_manage'
	end
end
