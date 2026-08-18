# frozen_string_literal: true

class CreateSocialLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :social_links do |t|
      t.references :profile, null: false, foreign_key: true, index: false
      t.string :platform, null: false
      t.string :url, null: false
      t.string :username
      t.string :icon
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :social_links, [ :profile_id, :position ]
    add_index :social_links, :platform
  end
end
