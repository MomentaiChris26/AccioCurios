class PagesController < ApplicationController
  authorize_resource :class => false
  skip_authorize_resource :only => :index
  
  def index
    @q = helpers.listing_search
  end

  def user_dashboard
    
  end



end
