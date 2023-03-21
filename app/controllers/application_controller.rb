# ApplicationController
class ApplicationController < ActionController::API
  class AuthenticationError < StandardError; end

  # Handle undefined method `parameter_missing'
  rescue_from ActiveRecord::RecordNotSaved, with: :handle_saving_error
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_saving_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_unauthenticated

  include ActionController::HttpAuthentication::Token

  private

  def authenticate
    token,  = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

  def handle_record_not_found(err)
    render json: { error: err.message }, status: :not_found
  end

  def handle_saving_error(err)
    render json: { 'error': err.message }, status: :unprocessable_entity
  end

  def parameter_missing(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    head :unauthorized
  end
end
