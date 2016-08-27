class CostsController < ApplicationController
	before_action :require_user
	def enroll
		@requests = Cost.where('buy_pament = ?', false)
	end

	def index
		@payments = Payment.where('category != ?', 0).all
		@revenues = Payment.where('category = ?', 0).all
		@category = {
      '0': '매출외수입',
      '1': '시설구매비',
      '2': '비품구매비',
      '3': '지기지원비',
      '4': '재료구매비',
      '5': '예비비'
    }
    @requests = Cost.where('buy_pament = ?', true)
	end

	def create
		enrollment = Payment.new
		enrollment.buy_date     = params[:buy_date]
		enrollment.category     = params[:category]
		enrollment.buy_content  = params[:buy_content]
		enrollment.price        = params[:price]
		enrollment.save

		redirect_to '/costs/enroll'
	end

	def request_create
		request = Cost.new
		request.material_id = params[:material]
		request.employee_id = params[:employee]
		request.buy_content = params[:buy_content]
		request.buy_price = params[:buy_price]
		request.buy_date = params[:buy_date]
		request.save

		redirect_to '/materials/request_buy'
	end

	def payment_check
		request = Cost.find(params[:id])
		request.buy_pament = true
		request.save

		redirect_to '/costs/enroll'
	end

	def getinfo
		@payment = Payment.find(params[:payment_num])
		render :json => @payment
	end

	def edit_payment
		payment = Payment.find(params[:id])
		payment.buy_date     = params[:buy_date]
		payment.category     = params[:category]
		payment.buy_content  = params[:buy_content]
		payment.price        = params[:price]
		payment.save

		redirect_to '/costs/index'
	end

	def balance
		params[:balance_year].nil? ? @year = Date.today().year() : @year = params[:balance_year]
		params[:balance_month].nil? ? @month = Date.today().month() : @month = params[:balance_month]
		params[:balance_money].nil? ? @money = 0 : @money = params[:balance_money]

		@sales_revs = Account.where('extract(year from account_date) = ? AND extract(month from account_date) = ?', @year, @month)
		@etc_revs = Payment.where('extract(year from buy_date) = ? AND extract(month from buy_date) = ? AND category = ?', 
																			@year, @month, 0)
		@material_costs = Cost.where('extract(year from buy_date) = ? AND extract(month from buy_date) = ?', @year, @month)
		@material2_costs = Payment.where('extract(year from buy_date) = ? AND extract(month from buy_date) = ? AND category != ?', 
																			@year, @month, 0)

		@category = {
      '0': '매출외수입',
      '1': '시설구매비',
      '2': '비품구매비',
      '3': '지기지원비',
      '4': '재료구매비',
      '5': '예비비'
    }
	end

end
