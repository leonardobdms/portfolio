# frozen_string_literal: true

module SetLocale
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  private

  def set_locale
    I18n.locale = LocaleResolver.call(
      cookies: cookies,
      accept_language: request.get_header("HTTP_ACCEPT_LANGUAGE")
    )
  end
end
