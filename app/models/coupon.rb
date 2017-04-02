class Coupon < ActiveRecord::Base
	has_many :mycoupons
	has_many :users, :through => :mycoupons
end
