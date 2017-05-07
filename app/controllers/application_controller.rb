class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_current_user_email
    current_user.email
  end 
end
