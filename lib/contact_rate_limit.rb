# frozen_string_literal: true

module ContactRateLimit
  TEST_STORE = ActiveSupport::Cache::MemoryStore.new

  module_function

  def increment(ip)
    key = "contacts:rate:#{ip}"
    count = (cache.read(key) || 0) + 1
    cache.write(key, count, expires_in: 1.hour)
    count
  end

  def reset!
    cache.clear
  end

  def cache
    Rails.env.test? ? TEST_STORE : Rails.cache
  end
end
