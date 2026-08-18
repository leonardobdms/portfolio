# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.string :kind, null: false
      t.string :label, null: false
      t.string :url, default: "", null: false
      t.integer :position, null: false, default: 0
      t.boolean :published, null: false, default: false

      t.timestamps
    end

    add_index :contacts, :position
    add_index :contacts, :kind
  end
end
