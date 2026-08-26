# frozen_string_literal: true

class Avo::Resources::Contact < Avo::BaseResource
  self.title = :subject
  self.visible_on_sidebar = false

  def fields
    field :name, as: :text, readonly: true
    field :email, as: :text, readonly: true
    field :subject, as: :text, readonly: true
    field :message, as: :textarea, readonly: true
    field :ip, as: :text, readonly: true
    field :user_agent, as: :text, readonly: true, hide_on: [ :index ]
    field :created_at, as: :date_time, readonly: true
  end

  def actions
    []
  end

  def filters
    []
  end
end
