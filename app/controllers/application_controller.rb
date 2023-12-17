class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  private

  def not_found(error)
    render json: { error: error }, status: :not_found
  end

  def not_destroyed(error)
    render json: { error: error }, status: :unprocessable_entity
  end
end
