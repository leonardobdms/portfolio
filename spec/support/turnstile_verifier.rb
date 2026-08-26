# frozen_string_literal: true

RSpec.configure do |config|
  config.before do |example|
    next if example.metadata[:turnstile]

    allow(TurnstileVerifier).to receive(:verify).and_return(true)
  end
end
