class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
  rescue_from Exception, with: :render_error
  before_action :token_match!

  def not_found_routing
    render(json: {
      success: false, error_message: 'Url not found.'
    }, status: 404)
  end

  private

  def render_not_found_error(exception)
    logger.warn("not found")
    render(json: {
      success: false, error_message: 'Can\'t find record.'
    }, status: 422)
  end

  def render_error(exception)
    logger.warn("render error: ")
    puts(exception)
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
    end
  end

end
