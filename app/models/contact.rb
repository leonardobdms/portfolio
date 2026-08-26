# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :name, :email, :subject, :message, presence: true
  validates :message, length: { minimum: 10, maximum: 5000 }
  validates :subject, length: { maximum: 200 }
  validates :name, length: { maximum: 120 }

  validates_email_format_of :email
end
