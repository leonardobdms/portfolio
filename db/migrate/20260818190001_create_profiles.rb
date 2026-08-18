# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :headline
      t.text :bio
      t.string :location
      t.string :email
      t.string :phone
      t.string :github_url
      t.string :linkedin_url
      t.string :website_url
      t.string :avatar_url
      t.string :resume_url
      t.boolean :available_for_work, null: false, default: false

      t.timestamps
    end
  end
end
