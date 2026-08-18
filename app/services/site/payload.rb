# frozen_string_literal: true

module Site
  class Payload
    def self.build
      new.build
    end

    def build
      {
        profile: profile_payload,
        skills: skills_payload,
        contacts: contacts_payload,
        experiences: experiences_payload,
        projects: projects_payload
      }
    end

    private

    def profile
      @profile ||= Profile.current
    end

    def profile_payload
      {
        name: profile.name,
        shortName: profile.short_name,
        headline: profile.headline,
        intro: profile.intro,
        about: profile.about_paragraphs,
        highlights: named_icons(profile.highlights_list),
        contactTitle: profile.contact_title,
        contactText: profile.contact_text,
        seoDescription: profile.seo_description,
        siteUrl: profile.site_url,
        copyrightYear: profile.copyright_year
      }
    end

    def skills_payload
      Skill.listed.ordered.map do |skill|
        {
          id: skill.id,
          name: skill.name,
          icon: skill.icon,
          level: skill.level
        }
      end
    end

    def contacts_payload
      Contact.published.ordered.filter_map do |contact|
        href = contact.href
        next if href.blank?

        {
          id: contact.id,
          label: contact.label,
          kind: contact.kind,
          href: href,
          external: contact.external?
        }
      end
    end

    def experiences_payload
      Experience.ordered.map do |experience|
        {
          id: experience.id,
          role: experience.role,
          company: experience.company.presence,
          period: experience.period,
          description: experience.description,
          technologies: named_icons(experience.technologies_list),
          url: experience.url.to_s
        }
      end
    end

    def projects_payload
      Project.ordered.map do |project|
        {
          id: project.id,
          name: project.name,
          slug: project.slug,
          summary: project.summary,
          description: project.description_paragraphs,
          role: project.role.to_s,
          icon: project.icon,
          url: project.url.to_s,
          github: project.github.to_s,
          technologies: named_icons(project.technologies_list),
          highlights: project.highlights_list,
          featured: project.featured?
        }
      end
    end

    def named_icons(names)
      icons = skill_icons
      Array(names).map { |item| { name: item, icon: icons[item.to_s.strip.downcase].to_s } }
    end

    def skill_icons
      @skill_icons ||= Skill.catalog
    end
  end
end
