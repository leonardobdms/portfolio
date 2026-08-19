# frozen_string_literal: true

module AvoLocale
  private

  def set_avo_locale(&action)
    I18n.with_locale(
      LocaleResolver.call(
        cookies: cookies,
        accept_language: request.get_header("HTTP_ACCEPT_LANGUAGE")
      ),
      &action
    )
  end
end
