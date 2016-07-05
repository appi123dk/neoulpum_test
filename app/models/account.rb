class Account < ActiveRecord::Base
	validates :account_date, uniqueness: true

	# 오늘의 수입을 출력하는 함수
	def self.today_revenue orders
		revenue = 0
		orders.each do |order|
			menu = Menu.find(order.menu_id)
			revenue += order.order_unit * menu.menu_price
		end
		return revenue
	end

	# 오늘의 비용을 출력하는 함수
	def self.today_cost orders
		cost = 0
		orders.each do |order|
			menu = Menu.find(order.menu_id)
			cost += order.order_unit * menu.unit_price
		end
		return cost
	end
end
