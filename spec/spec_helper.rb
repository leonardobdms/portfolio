# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  cover "app/models/**/*.rb",
        "app/serializers/**/*.rb",
        "app/controllers/**/*.rb",
        "app/mailers/**/*.rb",
        "app/helpers/**/*.rb",
        "lib/**/*.rb"

  skip "app/jobs/"

  group "Models", "app/models"
  group "Serializers", "app/serializers"
  group "Controllers", "app/controllers"
  group "Mailers", "app/mailers"
  group "Helpers", "app/helpers"
  group "Lib", "lib"
end
SimpleCov.minimum_coverage 100
