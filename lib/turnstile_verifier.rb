# frozen_string_literal: true

require "net/http"
require "json"

class TurnstileVerifier
  VERIFY_URL = "https://challenges.cloudflare.com/turnstile/v0/siteverify"

  def self.verify(token, remote_ip: nil)
    return false if token.blank?

    secret_key = ENV["TURNSTILE_SECRET_KEY"]
    return true if secret_key.blank? && Rails.env.local?

    uri = URI(VERIFY_URL)
    response = Net::HTTP.post_form(
      uri,
      {
        "secret" => secret_key,
        "response" => token,
        "remoteip" => remote_ip
      }.compact
    )

    return false unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body).fetch("success", false)
  rescue JSON::ParserError, SocketError, Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED
    false
  end
end
