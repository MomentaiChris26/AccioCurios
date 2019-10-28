class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show, :destory]
  # Page to show all listings. No login required for this page.
  def index
    @listings = Listing.all
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
      flash[:notice] = "Listing Sucessfully Created"
      redirect_to root_path
    end
  end

  def edit

  end
  
  def update

  end

  

  private 

  def set_user_listing
    if current_user.role?
      set_listing
    elsif @listing = current_user.listings.find_by_id(params[:id])
      if @listing == nil
        redirect_to listings_path
      else
        if @listing.price = nil
          @listing.price = 0
        end
      end
    end
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title,:posted_date,:price,:description,:sold,:condition_id,:user_id,:picture,category_attributes:[:id,:name,:_destroy])
  end

end
