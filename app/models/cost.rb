class Cost < ActiveRecord::Base
	belongs_to :material
	belongs_to :employee
end
