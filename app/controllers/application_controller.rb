class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_paramaters, if: :devise_controller?
  # rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  def get_current_user_email
    current_user.email
  end

  protected

  def configure_permitted_paramaters
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_image])
  end
end
