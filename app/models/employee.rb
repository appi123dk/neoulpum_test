class Employee < ActiveRecord::Base
	mount_uploader :employee_image, AvatarUploader
	has_many :teams
	has_many :costs

end
