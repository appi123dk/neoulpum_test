class OrdersController < ApplicationController
	def order_index
		@menus = Menu.all
		@pre_money = Account.where('account_date=?',Date.today()).take
	end

	def user_point
		@user = User.find(params[:user_id])
		@user.user_money -= params[:user_point].to_i
		@user.save
		render :json => @user
	end

	def find_user
		@user = User.where('user_number = ?', params[:user_number].to_s).take
		render :json => @user
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
		@end_money = Account.where('pre_money != ?', 0).last.end_money
	end
end
