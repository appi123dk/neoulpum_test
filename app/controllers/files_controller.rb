class FilesController < ApplicationController
	before_action :require_user
	def index
		
	end

	def data
		if params[:year].nil?
	      @year = Date.today().year()
	    else
	      @year = params[:year].to_i
	    end

		if Rails.env.production?
			@details = Detail.where('extract(year from created_at) = ?', @year)
	    else
	    	@details = Detail.where('cast(strftime("%Y", created_at) as int) = ?', @year)
		end
	end
end
