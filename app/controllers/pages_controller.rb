class PagesController < ApplicationController
  def search_results
  end

  def lockscreen
    render :layout => "empty"
  end

  def invoice
  end

  def invoice_print
    render :layout => "empty"
  end

  def login
    render :layout => "empty"
  end

  def login_2

    render :layout => "empty"

  end

  def forgot_password
      render :layout => "empty"
  end

  def register
    render :layout => "empty"
  end

  def internal_server_error
    render :layout => "empty"
  end

  def empty_page
  end

  def not_found_error
    render :layout => "empty"
  end

  # def confirm_duplication
  #   @user = User.where('user_email = ?',params[:user_email]).take
   
  #   respond_to do |format|
  #     if @user.nil?
  #       render 'register'
  #     else
  #       format.html { render "register" }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

end
