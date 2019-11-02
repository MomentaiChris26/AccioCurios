class PagesController < ApplicationController
  before_action :login_check, only: [:user_dashboard]
  
  def index
    @q = helpers.listing_search
  end

  def user_dashboard
    
  end

  private

  def login_check
    if user_signed_in? == false
      flash[:alert] = "Please Login To View Dashboard"
      redirect_to login_path
    else

    end
  end



end
