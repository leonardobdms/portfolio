# frozen_string_literal: true

module SeoHelper
  def person_json_ld(profile)
    {
      "@context" => "https://schema.org",
      "@type" => "Person",
      "name" => profile.name,
      "jobTitle" => profile.headline,
      "email" => profile.email,
      "url" => root_url,
      "address" => profile.location,
      "sameAs" => profile_social_urls(profile),
      "knowsAbout" => profile.skills.map(&:name),
      "alumniOf" => profile.educations.map(&:institution)
    }.compact
  end

  private

  def profile_social_urls(profile)
    urls = profile.social_links.map(&:url)
    urls += [ profile.github_url, profile.linkedin_url, profile.website_url ].compact
    urls.uniq
  end
end
