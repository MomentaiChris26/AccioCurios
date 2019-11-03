module PagesHelper

  def unsold_listings
    Listing.where(user_id: current_user.id, sold: 0)
  end

  def sold_listings
    Listing.where(user_id: current_user.id, sold: 1)
  end

  def purchase_listing
    PurchaseHistory.where(user_id: current_user.id)
  end

  def all_listings
    if user_signed_in?
      Listing.where(sold: 0).where.not(user_id: current_user.id)
    else
      Listing.where(sold: 0)
    end
  end

end
