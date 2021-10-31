class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
  rescue_from Exception, with: :render_error

  private

  def render_not_found_error(exception)
    render(json: {
      success: false, error_message: 'Kayıt bulunamadı.'
    }, status: 422)
  end

  def render_error(exception)
    render(json: {
      success: false, error_message: 'Kayıt bulunamadı.'
    }, status: 422)
  end
end
