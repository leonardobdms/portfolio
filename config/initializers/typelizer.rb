# frozen_string_literal: true

Typelizer.configure do |config|
  config.verbatim_module_syntax = true
  config.routes.enabled = true
  config.routes.output_dir = Rails.root.join("app/frontend/routes")
  config.routes.exclude = [
    %r{^/(up|rails|admin)},
    /active_storage/,
    /historical_location/
  ]
  config.output_dir = Rails.root.join("app/frontend/types/serializers")
end
