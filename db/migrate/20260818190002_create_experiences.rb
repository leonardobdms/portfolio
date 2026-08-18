# frozen_string_literal: true

class CreateExperiences < ActiveRecord::Migration[8.1]
  def change
    create_table :experiences do |t|
      t.references :profile, null: false, foreign_key: true, index: false
      t.string :company, null: false
      t.string :role, null: false
      t.string :employment_type
      t.string :location
      t.text :description
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :current, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :experiences, [ :profile_id, :position ]
  end
end
