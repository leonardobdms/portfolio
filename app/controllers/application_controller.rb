# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout "application"

  use_inertia_instance_props

  inertia_share locale: -> { I18n.locale.to_s }

  def after_sign_in_path_for(resource)
    return Avo.configuration.root_path if resource.is_a?(Admin)

    super
  end

  def after_sign_out_path_for(resource_or_scope)
    return new_admin_session_path if resource_or_scope == :admin

    super
  end
end
