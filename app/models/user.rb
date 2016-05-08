class User < ActiveRecord::Base
	validates :user_email, uniqueness: true
	validates	:user_number, uniqueness: true
	has_and_belongs_to_many :orders
	has_many :comments
end
