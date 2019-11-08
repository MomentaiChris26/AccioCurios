class ListingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_listing, only: [:show]
  before_action :set_q_variable


  def index
    # Uses the Ransack library to either show all listings or result results based on what the user inputs in the search bar
    @listings = @q.result(distinct: true) 
  end

  
  def show
    if user_signed_in?
    # assigns the session variable using the method from the listing helper, and creates a stripe session which takes specific parameters for stripe checkout.
      session = helpers.stripe_session 
    # Creates a session id for stripe. 
      @session_id = session.id 
    end
  end

  def new
    @listing = Listing.new # Initialises and assigns listing instance variable for create method.
  end

  # Provides method for create of listing using specific parameters and storing the listing into the database
  def create
    @listing = current_user.listings.create(listing_params)
    if @listing.errors.any?
      render 'new'
    else
      flash[:alert] = "Listing Sucessfully Created"
      redirect_to listings_path
    end
  end

  def edit

  end
  
  # Provides method for updating a listing in the database 
  def update
    if @listing.update(listing_params)
      flash[:alert] = "Listing Sucessfully Updated"
      redirect_to listings_path
    else
      render 'edit'
    end
  end

  # Provides method for destroying a listing from the database
  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  
  private 
  
  def set_q_variable # Sets q variable for ransack gem to utilise its search function
    @q = Listing.where(sold: 0).ransack(params[:q])
  end

  def set_listing # Sets the instance variable to the specific listing
    @listing = helpers.listing_pam
  end

  def listing_params
    params.require(:listing).permit(:title,:posted_date,:price,:description,:sold,:condition_id,:category_id,:user_id,:picture,category_attributes:[:id,:name,:_destroy],condition_attributes:[:id,:status,:_destroy])
  end

end
