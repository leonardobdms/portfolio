# frozen_string_literal: true

class CreateCertifications < ActiveRecord::Migration[8.1]
  def change
    create_table :certifications do |t|
      t.references :profile, null: false, foreign_key: true, index: false
      t.string :name, null: false
      t.string :issuer, null: false
      t.text :description
      t.string :credential_url
      t.string :credential_id
      t.date :issued_at
      t.date :expires_at
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :certifications, [ :profile_id, :position ]
  end
end
