class PaymentsController < ApplicationController
  before_action :listing_checker

  def success
    @listing_id = params["listingId"].to_i # Sets the listing id using the listing parameters in URL
    # Updates the buyer id in the listing to the current's user's id
    Listing.find(@listing_id).update(buyer_id: params["userId"].to_i,sold: 1) 
    # Creates a entry into the purchase history table which assigns the entry to the current user and the listing id
    PurchaseHistory.create(user_id: current_user.id, listing_id: @listing_id)
  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id
    p "listing id " + listing_id
    p "user id " + user_id
    status 200
  end


  private
  # Method to prevent users from being able to directly access the success page without purchasing something
  def listing_checker 
    if params["listingId"].nil?
      flash[:alert] = "You cannot access this page"
      redirect_to root_path
    end
    
  end
end
