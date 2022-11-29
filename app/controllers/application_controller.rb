class ApplicationController < ActionController::API
  rescue_from Exception, :with => :error_generic

  private

  def error_generic(exception)
    Rails.logger.info exception
    render json: {error: {message: "An error occured, please try again!",
                          error_description: exception.message}}, :status => :unprocessable_entity 
  end

  def stripe_error_handling(exception)
    Rails.logger.info exception
    render json: {error: {message: "An error occured, please try again!",
                          error_description: exception.message}}, :status => :unprocessable_entity 
  end
end