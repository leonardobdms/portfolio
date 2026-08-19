# frozen_string_literal: true

class Avo::Resources::Education < Avo::BaseResource
  self.title = :course
  self.icon = "tabler/outline/school"
  self.includes = [ :profile ]
  self.default_sort_column = :position
  self.default_sort_direction = :asc

  def fields
    field :id, as: :id, only_on: :show
    field :course, as: :text, sortable: true, link_to_record: true
    field :institution, as: :text, sortable: true
    field :degree, as: :text
    field :description, as: :textarea, hide_on: :index
    field :start_date, as: :date, sortable: true
    field :end_date, as: :date
    field :current, as: :boolean
    field :position, as: :number, sortable: true
    field :profile, as: :belongs_to, hide_on: :index, default: -> { Profile.order(:id).first }
  end
end
