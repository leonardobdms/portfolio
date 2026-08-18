# frozen_string_literal: true

module InertiaAuth
  extend ActiveSupport::Concern

  included do
    layout "application"
    before_action { @_inertia_instance_props = false }
  end

  private

  def auth_errors_for(record)
    record.errors.to_hash.transform_values(&:first)
  end

  def redirect_after_auth(path)
    if request.inertia?
      inertia_location path
    else
      redirect_to path
    end
  end
end
