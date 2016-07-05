class CostsController < ApplicationController
	def enroll
		@requests = Cost.where('buy_pament = ?', false)
	end

	def index
		@payments = Payment.all
		@category = {
      '1': '시설구매비',
      '2': '비품구매비',
      '3': '지기지원비'
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
end
