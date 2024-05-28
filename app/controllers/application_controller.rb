class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_bad_request

  private

  def render_bad_request
    render_error("Bad Request", 400)
  end

  def render_unprocessable_entity
    render_error("Unprocessable Entity", 422)
  end

  def render_error(error, status)
    render json: {errors: [error]}, status:
  end
end
