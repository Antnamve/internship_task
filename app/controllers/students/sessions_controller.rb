# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  def create
    token = Token.find_by(token: params[:student][:email])
    @student = token&.student
    if @student
      self.resource = warden.set_user(@student, scope: :student)
    else
      self.resource = warden.authenticate!(auth_options)
    end
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:token])
  end
end
