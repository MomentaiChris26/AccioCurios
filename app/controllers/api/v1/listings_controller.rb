module Api
  module V1
    class ListingsController < ApplicationController
      # GET /api/v1/listings
      def index
        @listings = Listing.includes(:user, :category, :condition).all
        render json: @listings, include: [:user, :category, :condition]
      end

      # GET /api/v1/listings/:id
      def show
        @listing = Listing.includes(:user, :category, :condition).find(params[:id])
        render json: @listing, include: [:user, :category, :condition]
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Listing not found' }, status: :not_found
      end
    end
  end
end
