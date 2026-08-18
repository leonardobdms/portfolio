# frozen_string_literal: true

class Education < ApplicationRecord
  belongs_to :profile

  validates :institution, :course, :start_date, presence: true
end
