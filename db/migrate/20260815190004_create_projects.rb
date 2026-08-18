# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :summary, null: false
      t.text :description, null: false
      t.string :role, default: "", null: false
      t.string :icon, null: false, default: "store"
      t.string :url, default: "", null: false
      t.string :github, default: "", null: false
      t.string :technologies, array: true, default: [], null: false
      t.string :highlights, array: true, default: [], null: false
      t.boolean :featured, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :projects, :slug, unique: true
    add_index :projects, :position
  end
end
