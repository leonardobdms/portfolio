# frozen_string_literal: true

class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.string :icon, null: false, default: ""
      t.integer :level, null: false, default: 1
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :skills, :position
    add_index :skills, :level
    add_index :skills, :name, unique: true
  end
end
