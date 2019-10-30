class ListingsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show, :destory, :admin_dashboard]
  before_action :set_listing, only: [:show]

  # Page to show all listings. No login required for this page.
  def index
    @listings = Listing.all
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
    helpers.list_condition
    @condition = Condition.new
  end
  
  private 

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title,:posted_date,:price,:description,:sold,:condition_id,:user_id,:picture,category_attributes:[:id,:name,:_destroy])
  end

end
