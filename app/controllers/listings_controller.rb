class ListingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_listing, only: [:show]

  def index
    @listings = Listing.where(sold: 0)
    @q = Listing.ransack(params[:q])
    @listings = @q.result(distinct: true)
  end
  
  def show

  end

  def new
    @listing = Listing.new
  end

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
  
  def update
    if @listing.update(listing_params)
      flash[:alert] = "Listing Sucessfully Updated"
      redirect_to listings_path
    else
      render 'edit'
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  
  def admin_dashboard

  end
  
  private 

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title,:posted_date,:price,:description,:sold,:condition_id,:category_id,:user_id,:picture,category_attributes:[:id,:name,:_destroy])
  end

end
