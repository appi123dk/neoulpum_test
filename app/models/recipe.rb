class Recipe < ActiveRecord::Base
	has_many :menus
	has_many :materials
end
