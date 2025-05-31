module Api
  module V1
    class SessionsController < Devise::SessionsController # Inheriting from Devise's controller
      skip_before_action :verify_authenticity_token, raise: false # Or :null_session

      respond_to :json

      # POST /api/v1/login
      def create
        self.resource = warden.authenticate(auth_options)
        if resource && resource.active_for_authentication?
          # Generate a simple token
          token_payload = { user_id: resource.id, exp: 2.weeks.from_now.to_i }
          # Using MessageVerifier to sign the token payload.
          # SECRET_KEY_BASE is generally suitable for this.
          # Ensure it's a strong key in production.
          # Consider a specific salt/purpose for the verifier for better security practice.
          verifier = ActiveSupport::MessageVerifier.new(Rails.application.credentials.secret_key_base, digest: 'SHA256')
          token = verifier.generate(token_payload)

          render json: {
            message: 'Logged in successfully.',
            token: token,
            user: resource_data(resource)
          }, status: :ok
        else
          render json: {
            message: 'Invalid email or password.'
          }, status: :unauthorized
        end
      end

      # DELETE /api/v1/logout
      def destroy
        # For the current simple token (signed, not stored, no blacklist):
        # - Server-side invalidation of this specific token is not feasible without a blacklist.
        # - Devise's sign_out method (if called via super or directly) typically invalidates session cookies,
        #   which are not the primary mechanism here (though it's good practice to call it if using
        #   any part of Devise's session management, even if just for CSRF tokens if they were active).
        # - The main responsibility for "logout" with such tokens falls on the client deleting the token.

        # Example: If Devise's sign_out is relevant for any underlying session state,
        # even if not for the token itself.
        # signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        # For a purely token-based API with sessions skipped, this might not do much.

        render json: { message: 'Logged out successfully. Please delete your token client-side.' }, status: :ok
      end

      private

      def resource_data(resource)
        { id: resource.id, email: resource.email, name: resource.name, username: resource.username }
      end

      # Devise methods overridden to ensure JSON response for failures
      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end
