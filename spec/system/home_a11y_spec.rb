# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home page", type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome, screen_size: [ 1400, 900 ])
    page.driver.browser.execute_cdp(
      "Emulation.setEmulatedMedia",
      features: [ { name: "prefers-reduced-motion", value: "reduce" } ]
    )
  end

  it "renders every content section when data exists" do
    create_complete_profile(name: "Ada Lovelace")

    visit root_path

    expect(page).to have_css("h1", text: "Ada Lovelace")
    expect(page).to have_css("#skills")
    expect(page).to have_css("#experience")
    expect(page).to have_css("#projects")
    expect(page).to have_css("#about")
    expect(page).to have_css("#certifications")
    expect(page).to have_css("#education")
    expect(page).to have_css("#contact")
    expect(page).to have_content("Portfolio CMS")
    expect(page).to have_content("Example Certification")
    expect(page).to have_content("Example University")
    expect(page).to be_axe_clean
  end

  it "hides empty optional sections" do
    create(
      :profile,
      name: "Minimal User",
      bio: nil,
      email: nil,
      phone: nil,
      github_url: nil,
      linkedin_url: nil,
      website_url: nil
    )

    visit root_path

    expect(page).to have_css("h1", text: "Minimal User")
    expect(page).to have_no_css("#skills")
    expect(page).to have_no_css("#experience")
    expect(page).to have_no_css("#projects")
    expect(page).to have_no_css("#about")
    expect(page).to have_no_css("#certifications")
    expect(page).to have_no_css("#education")
    expect(page).to have_no_css("#contact")
  end
end
