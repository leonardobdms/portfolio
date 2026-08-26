# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home accessibility", type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome, screen_size: [ 1400, 900 ])
    create(:profile)
  end

  it "passes axe checks on the home page" do
    visit root_path

    expect(page).to be_axe_clean
  end
end
