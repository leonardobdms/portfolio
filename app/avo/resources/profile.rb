# frozen_string_literal: true

class Avo::Resources::Profile < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/user"
  self.includes = []

  def fields
    field :id, as: :id, only_on: :show
    field :name, as: :text, sortable: true, link_to_record: true
    field :headline, as: :text
    field :bio, as: :textarea, hide_on: :index
    field :location, as: :text
    field :email, as: :text, hide_on: :index
    field :phone, as: :text, hide_on: :index
    field :github_url, as: :text, hide_on: :index
    field :linkedin_url, as: :text, hide_on: :index
    field :website_url, as: :text, hide_on: :index
    field :avatar_url, as: :text, hide_on: :index
    field :resume_url, as: :text, hide_on: :index
    field :available_for_work, as: :boolean
    field :experiences, as: :has_many
    field :educations, as: :has_many
    field :skills, as: :has_many
    field :projects, as: :has_many
    field :certifications, as: :has_many
    field :social_links, as: :has_many
  end
end
