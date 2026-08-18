# frozen_string_literal: true

class Avo::Resources::Profile < Avo::BaseResource
  self.title = :name
  self.icon = "tabler/outline/id"
  self.description = -> { I18n.t("avo.resources.profile.description") }
  self.record_selector = false

  def fields
    field :id, as: :id, hide_on: :index
    panel title: I18n.t("avo.resources.profile.panels.identity") do
      field :name, as: :text, required: true, link_to_record: true
      field :short_name, as: :text, required: true, help: I18n.t("avo.resources.profile.help.short_name"), width: 50
      field :headline, as: :text, required: true, width: 50
      field :intro, as: :textarea, required: true, rows: 3
      field :highlights, as: :tags, help: I18n.t("avo.resources.profile.help.highlights")
    end
    panel title: I18n.t("avo.resources.profile.panels.about") do
      field :about, as: :textarea, required: true, rows: 8, help: I18n.t("avo.resources.profile.help.about")
    end
    panel title: I18n.t("avo.resources.profile.panels.contact_seo") do
      field :contact_title, as: :text
      field :contact_text, as: :textarea, rows: 2
      field :seo_description, as: :textarea, rows: 3
      field :site_url, as: :text, help: I18n.t("avo.resources.profile.help.site_url")
      field :copyright_year, as: :number
    end
  end

  def render_index_controls(item:)
    []
  end

  def render_show_controls
    [
      Avo::Resources::Controls::BackButton.new,
      Avo::Resources::Controls::EditButton.new
    ]
  end

  def render_edit_controls
    [
      Avo::Resources::Controls::BackButton.new(label: I18n.t("avo.cancel").capitalize),
      Avo::Resources::Controls::SaveButton.new(resource: self)
    ]
  end

  def render_row_controls(item:)
    [
      Avo::Resources::Controls::ShowButton.new(item: item),
      Avo::Resources::Controls::EditButton.new(item: item)
    ]
  end
end
