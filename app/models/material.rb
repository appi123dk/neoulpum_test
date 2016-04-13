class Material < ActiveRecord::Base
	belongs_to :storage
	belongs_to :recipe
end
