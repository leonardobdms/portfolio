# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include InertiaAuth

  def new
    render_login
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    redirect_after_auth after_sign_in_path_for(resource)
  end

  private

  def render_login
    render inertia: "auth/login", props: {
      submitUrl: admin_session_path,
      forgotPasswordUrl: new_admin_password_path,
      homeUrl: root_path
    }
  end
end
