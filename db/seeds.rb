# frozen_string_literal: true

profile = Profile.current

skills = YAML.safe_load_file(Rails.root.join("db/seeds/skills.yml"))

skills.each_with_index do |attrs, index|
  attrs = attrs.symbolize_keys
  skill = Skill.find_or_initialize_by(name: attrs[:name])
  skill.assign_attributes(
    icon: attrs[:icon],
    level: attrs[:level],
    position: index
  )
  skill.save!
end

contacts = YAML.safe_load_file(Rails.root.join("db/seeds/contacts.yml"))

contacts.each_with_index do |attrs, index|
  attrs = attrs.symbolize_keys
  contact = Contact.find_or_initialize_by(kind: attrs[:kind])
  contact.assign_attributes(
    label: attrs[:label],
    url: attrs[:url].to_s,
    published: attrs.fetch(:published, false),
    position: index
  )
  contact.save!
end

experience = Experience.find_or_initialize_by(role: "Desenvolvedor Full Stack", period: "Jan 2023 - Jul 2026")
experience.assign_attributes(
  description: "Atuação no desenvolvimento e manutenção de aplicações web utilizando Ruby on Rails e Vue.js, trabalhando em APIs, integrações, sistemas administrativos e funcionalidades voltadas às necessidades dos clientes.",
  company: "Agência F12",
  url: "https://www.agenciaf12.com.br",
  technologies: [
    "Ruby",
    "Ruby on Rails",
    "RSpec",
    "Rswag / Swagger",
    "JavaScript",
    "Vue.js",
    "PHP",
    "WordPress",
    "PostgreSQL",
    "Banco de dados relacional",
    "API REST",
    "APIs",
    "CAS",
    "OpenAI API",
    "PagBank",
    "PayPal",
    "Nasajon",
    "GitLab"
  ],
  position: 0
)
experience.save!

Project.where(slug: %w[gestao-de-cidadania gestao-de-obras e-commerce]).delete_all
Project.where(name: [ "Gestão de Cidadania", "Gestão de Obras", "E-Commerce" ]).delete_all

projects = YAML.safe_load_file(Rails.root.join("db/seeds/projects.yml"))

projects.each do |attrs|
  attrs = attrs.symbolize_keys
  attrs[:description] = attrs[:description].to_s.strip

  project = Project.find_or_initialize_by(slug: attrs[:slug])
  project.assign_attributes(attrs)
  project.save!
end

admin_email = ENV["ADMIN_EMAIL"].presence
admin_password = ENV["ADMIN_PASSWORD"].presence

if Rails.env.local?
  admin_email ||= "admin@localhost"
  admin_password ||= "changeme"
end

if admin_email && admin_password
  Admin.find_or_create_by!(email: admin_email) do |admin|
    admin.password = admin_password
  end
end

puts "Seed ok. Perfil: #{profile.name}. Admin: #{admin_email || "não criado"}"
