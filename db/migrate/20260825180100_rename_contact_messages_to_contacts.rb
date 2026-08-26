# frozen_string_literal: true

class RenameContactMessagesToContacts < ActiveRecord::Migration[8.1]
  def up
    return unless table_exists?(:contact_messages)

    rename_table :contact_messages, :contacts
  end

  def down
    return unless table_exists?(:contacts)

    rename_table :contacts, :contact_messages
  end
end
