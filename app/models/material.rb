class Material < ActiveRecord::Base
	belongs_to :storage
	belongs_to :recipe
	has_many :costs
	belongs_to :employee
end
