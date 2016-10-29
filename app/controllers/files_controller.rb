class FilesController < ApplicationController
	before_action :require_user
	def index
		
	end

	def data
			@details = Detail.all
	end
end
