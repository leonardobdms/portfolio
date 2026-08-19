# frozen_string_literal: true

class HomeIndexSerializer < ApplicationSerializer
  one :profile, resource: ProfileSerializer
end
