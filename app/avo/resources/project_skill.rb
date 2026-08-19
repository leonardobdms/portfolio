# frozen_string_literal: true

class Avo::Resources::ProjectSkill < Avo::BaseResource
  self.title = -> { "#{record.project&.name} · #{record.skill&.name}" }
  self.icon = "tabler/outline/link"
  self.includes = [ :project, :skill ]
  self.visible_on_sidebar = false

  def fields
    field :id, as: :id, only_on: :show
    field :project, as: :belongs_to
    field :skill, as: :belongs_to
  end
end
