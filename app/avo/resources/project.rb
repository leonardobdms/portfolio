# frozen_string_literal: true

class Avo::Resources::Project < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/layout-grid"
  self.includes = [ :profile, :skills ]
  self.default_sort_column = :position
  self.default_sort_direction = :asc

  def fields
    field :id, as: :id, only_on: :show
    field :name, as: :text, sortable: true, link_to_record: true
    field :slug, as: :text, hide_on: :index
    field :short_description, as: :text, hide_on: :index
    field :description, as: :textarea, hide_on: :index
    field :image_url, as: :text, hide_on: :index
    field :github_url, as: :text, hide_on: :index
    field :demo_url, as: :text, hide_on: :index
    field :featured, as: :boolean, sortable: true
    field :position, as: :number, sortable: true
    field :start_date, as: :date, sortable: true
    field :end_date, as: :date
    field :profile, as: :belongs_to, hide_on: :index, default: -> { Profile.order(:id).first }
    field :skills, as: :has_many
  end
end
