module ListingsHelper
  
  def stripe_session
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
          name: @listing.title,
          description: @listing.description,
          amount: (@listing.price * 100).to_i,
          currency: 'aud',
          quantity: 1,
      }],

      payment_intent_data: {
          metadata: {
              user_id: current_user.id,
              listing_id: @listing.id
          }
      },
      success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@listing.id}",
      cancel_url: "#{root_url}listings"
      )
  end

  def search_params
    Listing.ransack(params[:q])
  end

  
end
