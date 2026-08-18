# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :headline, null: false
      t.text :intro, null: false
      t.text :about, null: false, default: ""
      t.string :highlights, array: true, default: [], null: false
      t.string :contact_title, null: false, default: "Vamos conversar?"
      t.text :contact_text, null: false, default: ""
      t.text :seo_description, default: "", null: false
      t.string :site_url, default: "", null: false
      t.integer :copyright_year, null: false

      t.timestamps
    end
  end
end
