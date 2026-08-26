# frozen_string_literal: true

require "rails_helper"

RSpec.describe TurnstileVerifier, :turnstile do
  def stub_secret(value)
    allow(ENV).to receive(:[]).and_wrap_original do |original, key|
      key == "TURNSTILE_SECRET_KEY" ? value : original.call(key)
    end
  end

  def stub_http(body:, success: true)
    response = instance_double(Net::HTTPResponse, body:)
    allow(response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(success)
    allow(Net::HTTP).to receive(:post_form).and_return(response)
  end

  it "rejects a blank token" do
    expect(described_class.verify(nil)).to be(false)
    expect(described_class.verify("")).to be(false)
  end

  it "accepts a token in local env when the secret is missing" do
    stub_secret(nil)

    expect(described_class.verify("token")).to be(true)
  end

  it "verifies a successful Cloudflare response" do
    stub_secret("secret")
    stub_http(body: '{"success":true}')

    expect(described_class.verify("token", remote_ip: "127.0.0.1")).to be(true)
  end

  it "rejects an unsuccessful Cloudflare response" do
    stub_secret("secret")
    stub_http(body: '{"success":false}')

    expect(described_class.verify("token")).to be(false)
  end

  it "rejects a non-success HTTP status" do
    stub_secret("secret")
    stub_http(body: "{}", success: false)

    expect(described_class.verify("token")).to be(false)
  end

  it "fails closed on invalid JSON" do
    stub_secret("secret")
    stub_http(body: "not-json")

    expect(described_class.verify("token")).to be(false)
  end

  it "fails closed on network errors" do
    stub_secret("secret")
    allow(Net::HTTP).to receive(:post_form).and_raise(SocketError)

    expect(described_class.verify("token")).to be(false)
  end

  it "posts to Cloudflare when the environment is not local" do
    stub_secret(nil)
    allow(Rails.env).to receive(:local?).and_return(false)
    stub_http(body: '{"success":false}')

    expect(described_class.verify("token")).to be(false)
  end
end
