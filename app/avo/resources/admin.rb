# frozen_string_literal: true

class Avo::Resources::Admin < Avo::BaseResource
  self.title = :email
  self.icon = "tabler/outline/shield-lock"
  self.description = -> { I18n.t("avo.resources.admin.description") }
  self.devise_password_optional = true
  self.search = {
    query: -> { query.where("email ILIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(q)}%") }
  }

  def fields
    field :id, as: :id, hide_on: :index
    field :email, as: :text, required: true, sortable: true, link_to_record: true
    field :password, as: :password, required: -> { view.new? }, hide_on: [ :index, :show ],
      help: I18n.t("avo.resources.admin.help.password")
    field :password_confirmation, as: :password, required: -> { view.new? }, hide_on: [ :index, :show ]
  end
end
