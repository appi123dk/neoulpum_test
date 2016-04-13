class Menu < ActiveRecord::Base
	belongs_to :menu_category
	belongs_to :recipe
	has_many :detail
	has_many :sale
end
