# frozen_string_literal: true

profile = Profile.find_or_initialize_by(name: "Leonardo Martins Bueno Dias")
profile.update!(
  headline: "Desenvolvedor Full Stack",
  bio: "Desenvolvedor com experiência em Ruby on Rails e Vue.js, atuando principalmente no desenvolvimento de aplicações web, APIs REST, integrações com serviços externos, sistemas de assinaturas e plataformas de negócio. Experiência com modelagem de bancos de dados, desenvolvimento e manutenção de sistemas, testes automatizados e integração de diferentes serviços e APIs.",
  location: "São Paulo, SP",
  available_for_work: true
)

experience = profile.experiences.find_or_initialize_by(
  role: "Desenvolvedor Full Stack",
  start_date: Date.new(2023, 1, 1)
)
experience.update!(
  company: "Atuação independente",
  employment_type: "PJ",
  location: "São Paulo, SP",
  description: "Desenvolvimento e manutenção de aplicações web utilizando principalmente Ruby on Rails e Vue.js, atuando na construção de APIs REST, modelagem de dados, integrações com serviços externos, sistemas de assinaturas, plataformas de negócio e automações. Experiência com testes automatizados utilizando RSpec, documentação de APIs e integração com diferentes serviços e meios de pagamento.",
  end_date: nil,
  current: true,
  position: 1
)

education = profile.educations.find_or_initialize_by(
  institution: "Anhanguera",
  course: "Análise e Desenvolvimento de Sistemas"
)
education.update!(
  degree: "Tecnólogo",
  description: "Formação em Análise e Desenvolvimento de Sistemas, com foco em desenvolvimento de software, programação, banco de dados, engenharia de software e tecnologias aplicadas ao desenvolvimento de sistemas.",
  start_date: Date.new(2026, 1, 1),
  end_date: Date.new(2029, 1, 1),
  current: true,
  position: 1
)

skills = {}

[
  { name: "Ruby", slug: "ruby", category: "backend", icon: "ruby", position: 1 },
  { name: "Ruby on Rails", slug: "ruby-on-rails", category: "backend", icon: "rails", position: 2 },
  { name: "REST APIs", slug: "rest-apis", category: "backend", icon: "api", position: 3 },
  { name: "RSpec", slug: "rspec", category: "backend", icon: "rspec", position: 4 },
  { name: "Rswag", slug: "rswag", category: "backend", icon: "swagger", position: 5 },
  { name: "PHP", slug: "php", category: "backend", icon: "php", position: 6 },
  { name: "Vue.js", slug: "vue-js", category: "frontend", icon: "vue", position: 7 },
  { name: "JavaScript", slug: "javascript", category: "frontend", icon: "javascript", position: 8 },
  { name: "PostgreSQL", slug: "postgresql", category: "database", icon: "postgresql", position: 9 },
  { name: "Git", slug: "git", category: "tools", icon: "git", position: 10 },
  { name: "GitHub", slug: "github", category: "tools", icon: "github", position: 11 },
  { name: "GitLab", slug: "gitlab", category: "tools", icon: "gitlab", position: 12 },
  { name: "Docker", slug: "docker", category: "tools", icon: "docker", position: 13 },
  { name: "OpenAI API", slug: "openai-api", category: "integrations", icon: "openai", position: 14 },
  { name: "WordPress", slug: "wordpress", category: "integrations", icon: "wordpress", position: 15 },
  { name: "PagBank", slug: "pagbank", category: "integrations", icon: "pagbank", position: 16 },
  { name: "PayPal", slug: "paypal", category: "integrations", icon: "paypal", position: 17 },
  { name: "Nasajon", slug: "nasajon", category: "integrations", icon: "nasajon", position: 18 }
].each do |attributes|
  skill = Skill.find_or_initialize_by(slug: attributes[:slug])
  skill.update!(attributes.merge(profile: profile))
  skills[attributes[:name]] = skill
end

projects = {}

[
  {
    name: "Gerenciamento de Cidadania Italiana",
    slug: "gerenciamento-cidadania-italiana",
    short_description: "Plataforma para gerenciamento de processos de cidadania italiana.",
    description: "Desenvolvimento de uma API para gerenciamento de solicitações de cidadania italiana, incluindo modelagem de dados, relacionamento entre processos, pedidos, status e estrutura familiar. O sistema foi desenvolvido para suportar o gerenciamento das informações do processo e sua comunicação entre diferentes usuários.\n\nTambém foi implementada uma funcionalidade de tradução de mensagens utilizando a OpenAI API, permitindo a comunicação entre profissionais italianos e clientes brasileiros.",
    featured: true,
    position: 1,
    skill_names: [ "Ruby", "Ruby on Rails", "PostgreSQL", "REST APIs", "RSpec", "Rswag", "OpenAI API" ]
  },
  {
    name: "Gerenciamento de Obras e Serviços",
    slug: "gerenciamento-obras-servicos",
    description: "Sistema desenvolvido para gerenciamento de obras e ordens de serviço, permitindo organizar trabalhos, acompanhar atividades e centralizar informações relacionadas aos serviços.",
    featured: true,
    position: 2,
    skill_names: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript", "REST APIs" ]
  },
  {
    name: "Plataforma de Locação",
    slug: "plataforma-locacao",
    description: "Sistema para gerenciamento de processos relacionados à locação, desenvolvido com backend em Ruby on Rails e integração com interface web.",
    featured: false,
    position: 3,
    skill_names: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript" ]
  },
  {
    name: "Sistema de Gestão de Pedidos",
    slug: "sistema-gestao-pedidos",
    description: "Sistema para gerenciamento de pedidos e operações relacionadas ao fluxo de vendas, desenvolvido com foco em organização dos dados, regras de negócio e integração entre diferentes partes da aplicação.",
    featured: false,
    position: 4,
    skill_names: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript", "REST APIs" ]
  },
  {
    name: "Plataforma de Cursos",
    slug: "plataforma-cursos",
    description: "Plataforma para gerenciamento e disponibilização de cursos e conteúdos, integrada a sistemas de autenticação e gerenciamento de usuários.",
    featured: false,
    position: 5,
    skill_names: [ "Ruby", "Ruby on Rails", "PostgreSQL", "WordPress", "REST APIs" ]
  },
  {
    name: "Plataforma de E-commerce",
    slug: "plataforma-ecommerce",
    description: "Desenvolvimento e manutenção de uma plataforma de comércio eletrônico, incluindo funcionalidades relacionadas a produtos, pedidos, clientes e integrações externas.",
    featured: false,
    position: 6,
    skill_names: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript", "REST APIs", "PagBank", "PayPal" ]
  },
  {
    name: "Sistema de Autenticação e SSO",
    slug: "sistema-autenticacao-sso",
    description: "Desenvolvimento de solução de autenticação e integração com sistemas externos, permitindo centralizar o processo de autenticação e controle de acesso.",
    featured: false,
    position: 7,
    skill_names: [ "Ruby", "Ruby on Rails", "PHP", "WordPress", "REST APIs" ]
  },
  {
    name: "Plugin de Autenticação WordPress",
    slug: "plugin-autenticacao-wordpress",
    description: "Desenvolvimento de plugin para WordPress integrado a uma API de autenticação, permitindo comunicação entre o WordPress e um sistema externo de autenticação.",
    featured: false,
    position: 8,
    skill_names: [ "PHP", "WordPress", "Ruby on Rails", "REST APIs" ]
  },
  {
    name: "Biblioteca de Integração de Autenticação",
    slug: "biblioteca-integracao-autenticacao",
    description: "Desenvolvimento de uma biblioteca Ruby para facilitar a integração de aplicações com um sistema externo de autenticação, encapsulando funcionalidades comuns e simplificando sua utilização em diferentes projetos.",
    featured: false,
    position: 9,
    skill_names: [ "Ruby", "Ruby on Rails", "REST APIs" ]
  }
].each do |attributes|
  project = Project.find_or_initialize_by(slug: attributes[:slug])
  project.update!(attributes.except(:skill_names).merge(profile: profile))
  projects[attributes[:slug]] = project

  attributes[:skill_names].each do |skill_name|
    ProjectSkill.find_or_create_by!(project: project, skill: skills.fetch(skill_name))
  end
end
