# frozen_string_literal: true

class Avo::Resources::Contact < Avo::BaseResource
  self.title = :subject
  self.icon = "tabler/outline/mail"
  self.default_sort_column = :created_at
  self.default_sort_direction = :desc

  def fields
    field :id, as: :id, only_on: :show
    field :name, as: :text, sortable: true, link_to_record: true
    field :email, as: :text, sortable: true
    field :subject, as: :text, sortable: true, link_to_record: true
    field :message, as: :textarea, hide_on: :index
    field :ip, as: :text, hide_on: :index
    field :user_agent, as: :text, hide_on: :index
    field :created_at, as: :date_time, sortable: true, hide_on: :forms
  end
end
