class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :admin_user

  def admin_user
  	if session[:user_id]
  		if User.find(session[:user_id]).admin
  			@admin_user ||= User.find(session[:user_id])
  		end
  	end
  end

  def require_user
  	redirect_to '/' unless admin_user
  end
end
