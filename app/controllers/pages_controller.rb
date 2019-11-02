class PagesController < ApplicationController

  def index
    @q = helpers.listing_search
  end

  def user_dashboard

  end

end
