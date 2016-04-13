class LandingController < ApplicationController
  def index
  	unless session[:user_id].nil?
  		@user = User.find(session[:user_id])
  	end
    render :layout => "empty"
  end

end