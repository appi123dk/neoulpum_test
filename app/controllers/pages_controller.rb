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

  def edit
    @user = User.find(params[:id])
    @colleges = Hash.new
    @colleges = {
      '1': '문과대학',
      '2': '법과대학',
      '3': '정경대학',
      '4': '경영대학',
      '5': '호텔관광대학',
      '6': '이과대학',
      '7': '생활과학대학',
      '8': '의과대학',
      '9': '한의과대학',
      '10': '치과대학',
      '11': '약학대학',
      '12': '간호과학대학',
      '13': '음악대학',
      '14': '미술대학',
      '15': '무용학부',
      '16': '자율전공학'
    }
    render :layout => "empty"
  end

  def register
    @colleges = Hash.new
    @colleges = {
      '1': '문과대학',
      '2': '법과대학',
      '3': '정경대학',
      '4': '경영대학',
      '5': '호텔관광대학',
      '6': '이과대학',
      '7': '생활과학대학',
      '8': '의과대학',
      '9': '한의과대학',
      '10': '치과대학',
      '11': '약학대학',
      '12': '간호과학대학',
      '13': '음악대학',
      '14': '미술대학',
      '15': '무용학부',
      '16': '자율전공학'
    }
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
