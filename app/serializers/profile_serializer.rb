# frozen_string_literal: true

class ProfileSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :headline,
             :bio,
             :location,
             :email,
             :phone,
             :github_url,
             :linkedin_url,
             :website_url,
             :avatar_url,
             :resume_url,
             :available_for_work,
             :created_at,
             :updated_at

  many :experiences, resource: ExperienceSerializer
  many :educations, resource: EducationSerializer
  many :skills, resource: SkillSerializer
  many :projects, resource: ProjectSerializer
  many :certifications, resource: CertificationSerializer
  many :social_links, resource: SocialLinkSerializer
end
