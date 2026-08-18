# frozen_string_literal: true

class Avo::Resources::Contact < Avo::BaseResource
  self.title = :label
  self.icon = "tabler/outline/address-book"
  self.description = -> { I18n.t("avo.resources.contact.description") }
  self.default_sort_column = :position
  self.default_sort_direction = :asc
  self.index_query = -> { query.ordered }
  self.search = {
    query: -> {
      query.where("label ILIKE :q OR kind ILIKE :q OR url ILIKE :q", q: "%#{ActiveRecord::Base.sanitize_sql_like(q)}%")
    }
  }

  def fields
    field :id, as: :id, hide_on: :index
    field :label, as: :text, required: true, link_to_record: true
    field :kind, as: :select, required: true, options: {
      I18n.t("activerecord.enums.contact.kind.github") => "github",
      I18n.t("activerecord.enums.contact.kind.linkedin") => "linkedin",
      I18n.t("activerecord.enums.contact.kind.email") => "email",
      I18n.t("activerecord.enums.contact.kind.other") => "other"
    }
    field :url, as: :text, help: I18n.t("avo.resources.contact.help.url")
    field :published, as: :boolean, help: I18n.t("avo.resources.contact.help.published")
    field :position, as: :number, sortable: true
  end
end
