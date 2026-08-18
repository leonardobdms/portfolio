# frozen_string_literal: true

class Admin < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  before_validation :omit_blank_password

  def name
    email
  end

  def is_admin?
    true
  end

  private

  def omit_blank_password
    self.password = nil if password.blank?
    self.password_confirmation = nil if password_confirmation.blank?
  end
end
