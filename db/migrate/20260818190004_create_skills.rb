# frozen_string_literal: true

class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.references :profile, null: false, foreign_key: true, index: false
      t.string :name, null: false
      t.string :slug, null: false
      t.string :category, null: false
      t.string :icon, null: false
      t.text :description
      t.string :level
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :skills, :slug, unique: true
    add_index :skills, :category
    add_index :skills, [ :profile_id, :position ]
  end
end
