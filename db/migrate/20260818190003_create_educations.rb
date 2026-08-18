# frozen_string_literal: true

class CreateEducations < ActiveRecord::Migration[8.1]
  def change
    create_table :educations do |t|
      t.references :profile, null: false, foreign_key: true, index: false
      t.string :institution, null: false
      t.string :course, null: false
      t.string :degree
      t.text :description
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :current, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :educations, [ :profile_id, :position ]
  end
end
