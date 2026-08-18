# frozen_string_literal: true

class Admins::PasswordsController < Devise::PasswordsController
  include InertiaAuth

  def new
    render_new
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      redirect_to after_sending_reset_password_instructions_path_for(resource_name)
    else
      render inertia: "auth/passwords/new", props: new_props.merge(errors: auth_errors_for(resource)),
        status: :unprocessable_content
    end
  end

  def edit
    super
    render inertia: "auth/passwords/edit", props: edit_props
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if sign_in_after_reset_password?
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      redirect_after_auth after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      render inertia: "auth/passwords/edit", props: edit_props.merge(errors: auth_errors_for(resource)),
        status: :unprocessable_content
    end
  end

  private

  def render_new
    render inertia: "auth/passwords/new", props: new_props
  end

  def new_props
    {
      submitUrl: admin_password_path,
      loginUrl: new_admin_session_path
    }
  end

  def edit_props
    {
      submitUrl: admin_password_path,
      loginUrl: new_admin_session_path,
      resetPasswordToken: resource.reset_password_token
    }
  end
end
