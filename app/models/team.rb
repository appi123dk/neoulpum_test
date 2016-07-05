class Team < ActiveRecord::Base
	belongs_to :employee
	belongs_to :semester
end
