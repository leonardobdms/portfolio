# frozen_string_literal: true

class CreateContactMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :contact_messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject, null: false
      t.text :message, null: false
      t.string :ip
      t.string :user_agent

      t.timestamps
    end
  end
end
