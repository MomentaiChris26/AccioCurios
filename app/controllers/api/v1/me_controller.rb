module Api
  module V1
    class MeController < Api::V1::BaseController
      # GET /api/v1/me
      def show
        # current_user is now available from BaseController's @current_user
        if current_user
          render json: {
            id: current_user.id,
            email: current_user.email,
            name: current_user.name,
            username: current_user.username
            # Add any other fields you want to expose about the current user
          }, status: :ok
        else
          # This else block should ideally not be reached if authenticate_request! works correctly,
          # as it would render an unauthorized error before hitting this action.
          # However, keeping it as a safeguard.
          render json: { error: 'Not authenticated or user data unavailable' }, status: :unauthorized
        end
      end
    end
  end
end
