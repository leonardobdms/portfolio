# frozen_string_literal: true

class CreateExperiences < ActiveRecord::Migration[8.1]
  def change
    create_table :experiences do |t|
      t.string :role, null: false
      t.string :company, default: "", null: false
      t.string :period, null: false
      t.text :description, null: false
      t.string :technologies, array: true, default: [], null: false
      t.string :url, default: "", null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :experiences, :position
  end
end
