module Api
  module V1
    class ConditionsController < Api::V1::BaseController
      skip_before_action :authenticate_request!, only: [:index] # Publicly accessible
      def index
        @conditions = Condition.all
        render json: @conditions
      end
    end
  end
end
