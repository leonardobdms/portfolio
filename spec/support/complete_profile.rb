# frozen_string_literal: true

module CompleteProfile
  def create_complete_profile(attrs = {})
    profile = create(
      :profile,
      {
        bio: "I build backend systems.\n\nI also enjoy Vue.",
        email: "owner@example.com",
        phone: "+55 11 94475-1977",
        github_url: "https://github.com/example",
        linkedin_url: "https://linkedin.com/in/example",
        website_url: "https://example.com",
        resume_url: "https://example.com/resume.pdf",
        available_for_work: true
      }.merge(attrs)
    )

    create(:skill, profile:, name: "Ruby", slug: "ruby", icon: "ruby", category: "Backend")
    create(:skill, profile:, name: "Vue", slug: "vue-js", icon: "vue-js", category: "Frontend")
    create(:experience, profile:, company: "Acme", role: "Engineer")
    create(:project, profile:, featured: true, name: "Portfolio CMS", slug: "portfolio-cms")
    create(:project, profile:, featured: false, name: "Hidden Work", slug: "hidden-work")
    create(:certification, profile:, name: "Example Certification")
    create(:education, profile:, institution: "Example University", course: "Computer Science")
    create(:social_link, profile:, platform: "GitHub", url: "https://github.com/example")

    profile.reload
  end
end

RSpec.configure do |config|
  config.include CompleteProfile
end
