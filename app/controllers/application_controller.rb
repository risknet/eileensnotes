class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :save_or_clear_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # reset all user defined sessions here
  def save_or_clear_session
    if controller_name.eql?('sessions') and (action_name.eql?('destroy') or action_name.eql?('delete'))
      #session[:user_name] = nil
    end
  end
  
  protected

  # updated on Nov 17, 2013
  # secure params and permit only these params for DEVISE
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :terms_of_service) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :name, :password, :password_confirmation, :current_password) }
  end
  
end
