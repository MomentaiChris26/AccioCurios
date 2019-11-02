module PaymentsHelper
  
  def listing_pam
    Listing.find(params[:id])
  end

end
