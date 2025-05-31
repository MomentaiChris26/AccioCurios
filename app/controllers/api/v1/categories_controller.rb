module Api
  module V1
    class CategoriesController < Api::V1::BaseController
      skip_before_action :authenticate_request!, only: [:index] # Publicly accessible index

      # GET /api/v1/categories
      def index
        @categories = Category.all
        render json: @categories
      end

      # index action remains as it was
    end
  end
end
