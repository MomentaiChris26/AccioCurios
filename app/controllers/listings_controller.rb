class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show, :destory]
  # Page to show all listings. No login required for this page.
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.create(listing_params)
    if @listing.errors.any?
      render 'new'
    else
      redirect_to root_path
    end
  end

  def show

  end
  

  private 

  def listing_params
    params.require(:listing).permit(:title,:posted_date,:price,:description,:sold,:condition_id,:user_id,:picture,category_attributes:[:id,:name,:_destroy])
  end

end
