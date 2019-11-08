class PagesController < ApplicationController
  before_action :login_check, only: [:user_dashboard]
  before_action :set_q_variable
  
  def index
    
  end

  def user_dashboard

  end

  private

  def login_check # Checks if a user is logged in and redirects them to login page if they're not
    if user_signed_in? == false
      flash[:alert] = "Please Login To View Dashboard"
      redirect_to login_path
    else

    end
  end

  def set_q_variable # Sets q variable for ransack gem to utilise its search function
    @q = Listing.ransack(params[:q])
  end


end
