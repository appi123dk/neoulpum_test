class FilesController < ApplicationController
	before_action :require_user
	def index
		
	end

	def data
		num = Detail.last.id
		if num < 300
			@details = Detail.last(num)
		else
			@details = Detail.last(300)
		end
	end
end
