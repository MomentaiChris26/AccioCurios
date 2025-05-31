module Api
  module V1
    class ListingsController < Api::V1::BaseController
      skip_before_action :authenticate_request!, only: [:index, :show] # Publicly accessible
      before_action :set_listing, only: [:update, :destroy]
      before_action :authorize_owner, only: [:update, :destroy]

      # GET /api/v1/listings
      def index
        @listings = Listing.includes(:user, :category, :condition).all
        render json: @listings.map { |listing| listing.as_json(include: [:user, :category, :condition]).merge(image_url: listing.image_url) }
      end

      # GET /api/v1/listings/:id
      def show
        @listing = Listing.includes(:user, :category, :condition).find(params[:id])
        render json: @listing.as_json(include: [:user, :category, :condition]).merge(image_url: @listing.image_url)
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Listing not found' }, status: :not_found
      end

      # POST /api/v1/listings
      def create
        # current_user is available from BaseController
        @listing = current_user.listings.build(listing_params)

        if @listing.save
          render json: @listing.as_json(include: [:user, :category, :condition]).merge(image_url: @listing.image_url), status: :created
        else
          render json: { errors: @listing.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/listings/:id
      def update
        if @listing.update(listing_params)
          render json: @listing.as_json(include: [:user, :category, :condition]).merge(image_url: @listing.image_url)
        else
          render json: { errors: @listing.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/listings/:id
      def destroy
        @listing.destroy
        # head :no_content # Standard response for successful DELETE
        render json: { message: 'Listing deleted successfully' }, status: :ok
      end

      private

      def set_listing
        @listing = Listing.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Listing not found' }, status: :not_found
      end

      def authorize_owner
        unless @listing.user_id == current_user.id
          render json: { error: 'You are not authorized to perform this action.' }, status: :forbidden
        end
      end

      def listing_params
        params.require(:listing).permit(:title, :description, :price, :category_id, :condition_id, :image, :sold) # Added :sold
        # Note: Added :sold to params. User should be able to mark as sold.
        # Image can be updated/removed. If :image is passed as null/empty, ActiveStorage might detach it.
        # Consider if :image should be handled separately for removal if ActiveStorage doesn't do it by default on empty param.
      end
    end
  end
end
