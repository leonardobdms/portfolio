# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  cover "app/models/**/*.rb", "app/serializers/**/*.rb"
  group "Models", "app/models"
  group "Serializers", "app/serializers"
  group "Controllers", "app/controllers"
  group "Mailers", "app/mailers"
  group "Helpers", "app/helpers"
end
SimpleCov.minimum_coverage 100
