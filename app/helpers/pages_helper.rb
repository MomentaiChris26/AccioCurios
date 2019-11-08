module PagesHelper

  def unsold_listings # Method to retrieve all listings with the condition sold 0
    Listing.where(user_id: current_user.id, sold: 0)
  end

  def sold_listings # Method to retrieve all listings with the condition sold 1
    Listing.where(user_id: current_user.id, sold: 1)
  end

  def purchase_listing # Method retreieve all of the user's purchase history
    PurchaseHistory.where(user_id: current_user.id)
  end

  def all_listings_unsold # Method for all listings page to remove listings not belong to the user and is unsold
    if user_signed_in?
      Listing.where(sold: 0).where.not(user_id: current_user.id)
    else
      Listing.where(sold: 0)
    end
  end

  def all_listings # Method to retrieve all listings
    Listing.all
  end

  

end
