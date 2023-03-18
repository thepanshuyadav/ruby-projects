module Api
  module V1
    # UsersController
    class UsersController < ApplicationController
      def create
        # Create new user
        user = User.new(user_params)
        if user.save
          render json: UserRepresenter.new(user).as_json, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name)
      end
    end
  end
end
