# frozen_string_literal: true

module SerializerHelpers
  def serialize_json(object, serializer = described_class)
    JSON.parse(serializer.new(object).serialize)
  end
end

RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{/spec/serializers/}) do |metadata|
    metadata[:type] = :serializer
  end

  config.include SerializerHelpers, type: :serializer
end
