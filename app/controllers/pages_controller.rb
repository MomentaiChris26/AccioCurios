class PagesController < ApplicationController

  def index
    @q = helpers.listing_search
  end

end
