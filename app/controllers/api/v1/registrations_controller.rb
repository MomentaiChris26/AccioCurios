module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController # Inheriting from Devise's controller
      # Skip CSRF protection for API calls, ensure this is appropriate for your security model.
      # If you have another base API controller, consider inheriting from it if it handles this.
      skip_before_action :verify_authenticity_token, raise: false # Or use :null_session

      respond_to :json

      # POST /api/v1/signup
      def create
        build_resource(sign_up_params)

        if resource.save
          # Sign in the user: No, not for API unless we return a token immediately.
          # For stateless API, just confirm creation.
          # If you want to return a token here, you'd call a method to generate it.
          render json: {
            message: 'Signed up successfully.',
            user: resource_data(resource) # Or a more detailed serializer/view
          }, status: :created
        else
          render json: {
            message: 'Sign up failed.',
            errors: resource.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :username) # Add :name or any other permitted user attributes
      end

      def resource_data(resource)
        # Helper to select what user data to return
        { id: resource.id, email: resource.email, name: resource.name, username: resource.username } # Customize as needed
      end
    end
  end
end
