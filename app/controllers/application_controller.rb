class ApplicationController < ActionController::Base
  helper Railsui::ThemeHelper

  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :surname, :avatar, :name, :school_id, :class_id, :confirm_success_url])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :school_id, :class_id, :confirm_success_url])
  end
end
