class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
  rescue_from Exception, with: :render_error
  before_action :token_match!

  private

  def render_not_found_error(exception)
    render(json: {
      success: false, error_message: 'Can\'t find record.'
    }, status: 422)
  end

  def render_error(exception)
    render(json: {
      success: false, error_message: 'Can\'t find record.'
    }, status: 422)
  end

  def token_match!
    token = request.headers['Access-Token']
    unless token.eql?("Aa1234")
      render(json: {
        success: false, error_message: 'Unauthorized request.'
      }, status: 422)
      render json: { success: false, error_message: "Unauthorized request" }, status: 422
    end
  end
end
