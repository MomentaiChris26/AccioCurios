module PagesHelper
  
  def listing_search
    Listing.ransack(params[:q])
  end

  def unsold_listings
    Listing.where(user_id: current_user.id, sold: 0)
  end

  def sold_listings
    Listing.where(user_id: current_user.id, sold: 1)
  end

  def purchase_listing
    PurchaseHistory.where(user_id: current_user.id)
  end

end
