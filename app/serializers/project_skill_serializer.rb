# frozen_string_literal: true

class ProjectSkillSerializer < ApplicationSerializer
  attributes :id,
             :project_id,
             :skill_id,
             :created_at,
             :updated_at

  one :skill, resource: SkillSerializer
end
