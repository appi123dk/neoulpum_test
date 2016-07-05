class Detail < ActiveRecord::Base
	belongs_to :menus
	belongs_to :order

	#오늘의 모든 주문 --> account로 연결
	def self.today_orders
		return Detail.where(created_at: Time.now.midnight..(Time.now.midnight + 1.day))
	end
end
