# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :profile, null: false, foreign_key: true, index: false
      t.string :name, null: false
      t.string :slug, null: false
      t.string :short_description
      t.text :description
      t.string :image_url
      t.string :github_url
      t.string :demo_url
      t.boolean :featured, null: false, default: false
      t.integer :position, null: false, default: 0
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    add_index :projects, :slug, unique: true
    add_index :projects, :featured
    add_index :projects, [ :profile_id, :position ]
  end
end
