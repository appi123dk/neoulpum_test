class OrdersController < ApplicationController
	before_action :require_user
	def order_index
		@promo_menus = Menu.where('display = ? AND menu_promo = ?', true, true).order("menu_order")
		@etc_menus = Menu.where('display = ? AND menu_category_id = ?', true, 5).order("menu_order")
		@coffee_menus = Menu.where('display = ? AND menu_category_id = ?',true, 1).order("menu_order")
		@tea_menus = Menu.where('display = ? AND menu_category_id = ?',true, 2).order("menu_order")
		@drink_menus = Menu.where('display = ? AND menu_category_id = ?',true, 3).order("menu_order")
		@food_menus = Menu.where('display = ? AND menu_category_id = ?',true, 4).order("menu_order")
		@pre_money = Account.where('account_date=?',Date.today()).take
		@admin_user = User.where('user_email = ?', "admin@neoulpum.com").take
	end

	def user_point
		@user = User.find(params[:user_id])
		@user.user_money -= params[:user_point].to_i
		@user.save
		@coupons = @user.coupons
		@mycoupons = @user.mycoupons

		render json: {users: @user, coupons: @coupons, mycoupons: @mycoupons }
	end

	def user_coupon
		@user = User.find(params[:user_id])
		@user.user_money += params[:user_point].to_i
		@user.save
		@coupons = @user.coupons
		@mycoupons = @user.mycoupons

		render json: {users: @user, coupons: @coupons, mycoupons: @mycoupons }
	end

	def use_coupon
		@user = User.find(params[:user_id])
		@coupons = @user.coupons
		@mycoupons = @user.mycoupons

		mycoupon = @mycoupons.where('coupon_id = ?', params[:coupon_id]).take
		mycoupon.unit += 1
		mycoupon.save

		@coupon_price = mycoupon.coupon.price

		render json: {users: @user, coupons: @coupons, mycoupons: @mycoupons, coupon_price: @coupon_price }
	end

	def user_prepoint
		@user = User.find(params[:user_id])
		@user.user_money += params[:user_point].to_i
		@user.save

		account = Account.last
		account.saving_point += params[:user_point].to_i
		account.save
		
		@coupons = @user.coupons
		@mycoupons = @user.mycoupons

		render json: {users: @user, coupons: @coupons, mycoupons: @mycoupons }
	end

	def find_user
		employee = Employee.where('employee_phone = ?', params[:user_number].to_s).take
		if employee.nil?
			@user = User.where('user_number = ?', params[:user_number].to_s).take
			@employee = employee
			@coupons = @user.coupons
			@mycoupons = @user.mycoupons
		else
			@user = User.where('user_number = ?', "0").take
			@employee = employee
			@coupons = @user.coupons
			@mycoupons = @user.mycoupons
		end

		render json: {employee: @employee, users: @user, coupons: @coupons, mycoupons: @mycoupons }
	end

	def order_create
		order = Order.new
		order.order_number = params[:order_number]
		order.use_point = params[:use_point]

		# 카카오페이 여부
		unless params[:is_kakao].nil?
			order.is_kakao = true
		end
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
			unless user.is_group
				#텀블러 적용
				# unless params[:tumbler].nil?
				# 	user.user_money += 100
				# end

				#등급별 차등적용
				if user.user_rate == 0
					user.user_money += point * 0.105
				elsif user.user_rate == 1
					user.user_money += point * 0.11
				elsif user.user_rate == 2
					user.user_money += point * 0.13
				else
					user.user_money += point * 0.15
				end
				user.save
			end
		end

		redirect_to '/orders/order_index'
	end

	def order_manage
		@pre_money = Account.where('account_date=?',Date.today()).take
		@orders = Order.limit(50).order('id desc').where('make_confirm = ?', false).reverse_order
		@shot = 0
		@make_orders = Order.limit(50).order('id desc').where('order_confirm = ? AND make_confirm = ?', false, true).reverse_order
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

		unless order.users.empty?
			user = order.users.last
			user.count += 1
			count = user.count
			rate = user.user_rate
			if count < 10
				rate = 0
			elsif count < 45
				rate = 1
			elsif count < 99
				rate = 2
			else
				rate = 3
			end
			user.user_rate = rate
			user.save
		end

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

		# 적립금 삭제
		order_user = order.users.take
		point = 0
		order.details.each do |menu|
			point += menu.menu.menu_price * menu.order_unit
		end

		unless order_user.nil?
			if order_user.user_rate == 0
				order_user.user_money -= point * 0.105
			elsif order_user.user_rate == 1
				order_user.user_money -= point * 0.11
			elsif order_user.user_rate == 2
				order_user.user_money -= point * 0.13
			else
				order_user.user_money -= point * 0.15
			end
			order_user.save
		end

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
