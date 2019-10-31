module PagesHelper
  def listing_search
    Listing.ransack(params[:q])
  end


end
