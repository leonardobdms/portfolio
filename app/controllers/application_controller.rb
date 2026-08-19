class ApplicationController < ActionController::Base
  include SetLocale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  inertia_share locale: -> { I18n.locale.to_s }
end
