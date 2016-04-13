class Detail < ActiveRecord::Base
	belongs_to :menus
	belongs_to :order
end
