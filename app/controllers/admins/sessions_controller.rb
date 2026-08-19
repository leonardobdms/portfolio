# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      render inertia: login_props
    end

    def create
      self.resource = warden.authenticate(auth_options)

      if resource
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        inertia_location after_sign_in_path_for(resource)
      else
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        flash.now[:alert] = I18n.t(
          "devise.failure.invalid",
          authentication_keys: Admin.human_attribute_name(:email)
        )
        render inertia: "admins/sessions/new",
               props: login_props,
               status: :unprocessable_content
      end
    end

    protected

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || Avo.configuration.root_path
    end

    private

    def login_props
      {
        email: resource.email,
        session_url: admin_session_path
      }
    end
  end
end
