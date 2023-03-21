module Api
  module V1
    # AuthenticationController
    class AuthenticationController < ApplicationController

      def create
        user = User.find_by(id: params.require(:user_id))
        raise AuthenticationError unless user.authenticate(params.require(:password))

        generated_token = AuthenticationTokenService.call(user.id)
        render json: { token: generated_token }, status: :created
      end
    end
  end
end
