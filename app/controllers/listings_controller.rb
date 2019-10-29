require 'common_stuff'
class ListingsController < ApplicationController
  include CommonStuff
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show, :destory]
  before_action :set_listing, only: [:show]
  before_action :set_user_listing, only: [:edit, :update, :destroy]

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
    if @listing.update(listing_params)
      flash[:notice] = "Listing Sucessfully Updated"
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

  def set_user_listing
    if current_user.admin?
      set_listing
    elsif @listing = current_user.listings.find_by_id(params[:id])
      if @listing == nil
        redirect_to listings_path
      else
        if @listing.price = nil
          @listing.price = 0.00
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
