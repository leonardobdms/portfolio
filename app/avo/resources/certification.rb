# frozen_string_literal: true

class Avo::Resources::Certification < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/certificate"
  self.includes = [ :profile ]
  self.default_sort_column = :position
  self.default_sort_direction = :asc

  def fields
    field :id, as: :id, only_on: :show
    field :name, as: :text, sortable: true, link_to_record: true
    field :issuer, as: :text, sortable: true
    field :description, as: :textarea, hide_on: :index
    field :credential_url, as: :text, hide_on: :index
    field :credential_id, as: :text, hide_on: :index
    field :issued_at, as: :date, sortable: true
    field :expires_at, as: :date
    field :position, as: :number, sortable: true
    field :profile, as: :belongs_to, hide_on: :index, default: -> { Profile.order(:id).first }
  end
end
