# frozen_string_literal: true

class Avo::Resources::Skill < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/code"
  self.includes = [ :profile ]
  self.default_sort_column = :position
  self.default_sort_direction = :asc

  def fields
    field :id, as: :id, only_on: :show
    field :name, as: :text, sortable: true, link_to_record: true
    field :slug, as: :text, sortable: true
    field :category, as: :text, sortable: true
    field :icon, as: :text
    field :level, as: :text
    field :description, as: :textarea, hide_on: :index
    field :position, as: :number, sortable: true
    field :profile, as: :belongs_to, hide_on: :index, default: -> { Profile.order(:id).first }
    field :projects, as: :has_many
  end
end
