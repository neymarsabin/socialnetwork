class ApplicationController < ActionController::Base
  include Pundit
  include PublicActivity::StoreController 


  protect_from_forgery with: :exception
  before_action :configure_permitted_paramaters, if: :devise_controller?
  before_action :configure_permitted_paramaters_for_registration, if: :devise_controller?
  #rescue_from ActiveRecord::RecordNotFound, :with => {:render => "404"}

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to question_path, :alert => exception.message
  end
   
  def get_current_user_email
    current_user.email
  end

  protected

  def configure_permitted_paramaters
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_image,:username])
  end

  def configure_permitted_paramaters_for_registration
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
