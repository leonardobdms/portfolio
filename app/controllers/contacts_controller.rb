# frozen_string_literal: true

class ContactsController < ApplicationController
  RATE_LIMIT = 5

  before_action :enforce_rate_limit, only: :create

  def create
    if honeypot?(contact_params)
      redirect_to root_path(anchor: "contact"), notice: I18n.t("contact.success")
      return
    end

    unless captcha_valid?
      redirect_to root_path(anchor: "contact"), inertia: {
        errors: { captcha: I18n.t("contact.captcha_failed") }
      }
      return
    end

    @contact = Contact.new(message_attributes)
    @contact.ip = request.remote_ip
    @contact.user_agent = request.user_agent

    if @contact.save
      ContactMailer.new_message(@contact).deliver_later
      redirect_to root_path(anchor: "contact"), notice: I18n.t("contact.success")
    else
      redirect_to root_path(anchor: "contact"), inertia: { errors: form_errors(@contact) }
    end
  end

  private

  def enforce_rate_limit
    count = ContactRateLimit.increment(request.remote_ip)

    if count > RATE_LIMIT
      flash[:alert] = I18n.t("contact.rate_limited")
      redirect_to root_path(anchor: "contact")
    end
  end

  # Inertia expects one message string per field, while `errors.to_hash` returns
  # arrays of partial messages.
  def form_errors(record)
    record.errors.to_hash(true).transform_values(&:first)
  end

  def contact_params
    params.permit(:name, :email, :subject, :message, :website, "cf-turnstile-response")
  end

  def message_attributes
    contact_params.except(:website, "cf-turnstile-response")
  end

  def honeypot?(attributes)
    attributes[:website].present?
  end

  def captcha_valid?
    TurnstileVerifier.verify(turnstile_token, remote_ip: request.remote_ip)
  end

  def turnstile_token
    contact_params["cf-turnstile-response"]
  end
end
