class PaymentsController < ApplicationController
  before_action :listing_checker

  def success
    @listing_id = params["listingId"].to_i
    Listing.find(@listing_id).update(buyer_id: params["userId"].to_i)
    Listing.find(@listing_id).update(sold: 1)
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

  def listing_checker
    if params["listingId"].nil?
      flash[:alert] = "You cannot access this page"
      redirect_to root_path
    end
    
  end
end
