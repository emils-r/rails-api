class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def not_found(error)
    render json: { error: error }, status: :not_found
  end

  def not_destroyed(error)
    render json: { error: error }, status: :unprocessable_entity
  end

  def parameter_missing(error)
    render json: { error: error }, status: :bad_request
  end
end
