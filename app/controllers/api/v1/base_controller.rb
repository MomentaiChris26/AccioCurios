module Api
  module V1
    class BaseController < ActionController::API # Inherit from ActionController::API for API-specific features
      # Include ActionController::HttpAuthentication::Token::ControllerMethods if needed for other token types,
      # but for our custom Bearer token, manual parsing is fine.

      attr_reader :current_user

      before_action :authenticate_request!

      private

      def authenticate_request!
        token = extract_token_from_header
        if token
          payload = verify_token(token)
          if payload && Time.at(payload[:exp]) > Time.current
            @current_user = User.find_by(id: payload[:user_id])
            unless @current_user
              render json: { error: 'User not found for token' }, status: :unauthorized and return
            end
          else
            render json: { error: 'Token invalid or expired' }, status: :unauthorized and return
          end
        else
          render json: { error: 'Authorization header missing or token malformed' }, status: :unauthorized and return
        end
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        render json: { error: 'Token signature invalid' }, status: :unauthorized and return
      rescue ActiveRecord::RecordNotFound # Should be caught by @current_user check
        render json: { error: 'User not found' }, status: :unauthorized and return
      rescue => e # Catch other potential errors during token processing
        render json: { error: "Authentication error: #{e.message}" }, status: :unauthorized and return
      end

      def extract_token_from_header
        header = request.headers['Authorization']
        header.split(' ').last if header&.starts_with?('Bearer ')
      end

      def verify_token(token)
        verifier = ActiveSupport::MessageVerifier.new(Rails.application.credentials.secret_key_base, digest: 'SHA256')
        verifier.verify(token) # verify will raise InvalidSignature if tampered or wrong secret
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil # Or re-raise, handled by authenticate_request!
      end
    end
  end
end
