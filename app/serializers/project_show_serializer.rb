# frozen_string_literal: true

class ProjectShowSerializer < ApplicationSerializer
  one :profile, resource: ProfileSerializer
  one :project, resource: ProjectSerializer

  attributes :previous_slug, :next_slug
end
