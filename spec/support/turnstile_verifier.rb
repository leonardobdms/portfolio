# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    allow(TurnstileVerifier).to receive(:verify).and_return(true)
  end
end
