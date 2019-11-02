class PagesController < ApplicationController

  def index
    @q = helpers.listing_search
  end

  def user_dashboard
    @listings = Listing.where(:id == current_user.id)
  end

end
