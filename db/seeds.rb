# frozen_string_literal: true

if Rails.env.local?
  Admin.find_or_create_by!(email: "admin@admin.com") do |admin|
    admin.password = "password@123"
  end
end

# Previous slugs kept so re-running the seed updates existing records
# instead of creating duplicates after anonymized names changed.
PROJECT_SLUG_ALIASES = {
  "gerenciamento-cidadania-italiana" => "plataforma-gestao-cidadania",
  "gerenciamento-obras-servicos" => "plataforma-gestao-obras-servicos",
  "plataforma-cursos" => "plataforma-conteudo-cursos",
  "sistema-autenticacao-sso" => "sistema-autenticacao-centralizada",
  "plugin-autenticacao-wordpress" => "plugin-integracao-wordpress"
}.freeze

ActiveRecord::Base.transaction do
  profile = Profile.find_or_initialize_by(name: "Leonardo Martins Bueno Dias")
  profile.assign_attributes(
    headline: "Desenvolvedor Full Stack | Ruby on Rails & Vue.js",
    bio: <<~BIO.squish,
      Desenvolvedor Full Stack com foco em Ruby, Ruby on Rails e Vue.js.
      Desde 2023 atuo no desenvolvimento, manutenção e evolução de aplicações
      web, incluindo APIs RESTful, regras de negócio, integrações entre
      sistemas e validações em ambiente de QA.

      Experiência com PostgreSQL, Redis, Sidekiq, Docker, Docker Compose,
      testes automatizados com RSpec, documentação de APIs com Rswag/OpenAPI,
      webhooks e integração com APIs de terceiros, incluindo OpenAI API e
      gateways de pagamento. Também atuei com autenticação centralizada,
      WordPress/PHP, assinaturas recorrentes e integrações fiscais.
    BIO
    location: "São Paulo, SP",
    email: "leo.bdms@gmail.com",
    phone: "+55 (11) 94475-1977",
    github_url: "https://github.com/leonardobdms",
    linkedin_url: "https://www.linkedin.com/in/leonardomartinsbd/",
    website_url: nil,
    resume_url: nil,
    avatar_url: nil,
    available_for_work: true
  )
  profile.save!

  experience = profile.experiences.find_or_initialize_by(
    role: "Desenvolvedor Full Stack",
    start_date: Date.new(2023, 1, 1)
  )
  experience.assign_attributes(
    company: "Agência F12",
    employment_type: "PJ",
    location: "São Paulo, SP",
    current: false,
    end_date: Date.new(2026, 7, 31),
    position: 1,
    description: <<~TEXT.strip
      Desenvolvimento, manutenção e evolução de aplicações web, com participação na implementação de novas funcionalidades, correções, melhorias, integrações e validações em ambiente de QA.

      A atuação envolveu diferentes contextos de negócio, incluindo e-commerce, gestão de obras, locação de produtos, publicação de conteúdo, processos fiscais, cidadania italiana, portais corporativos, autenticação centralizada e assinaturas recorrentes.

      O trabalho foi feito principalmente com Ruby on Rails e Vue.js, além de Nuxt.js quando o frontend exigia. Incluiu APIs RESTful, PostgreSQL, Redis, Sidekiq, Docker, testes com RSpec, documentação de APIs com Rswag/OpenAPI, webhooks e integrações com APIs de terceiros, incluindo OpenAI API, PagBank e PayPal. Também houve atuação em integrações fiscais (NFS-e, RPS, comunicação com prefeituras e automação de fluxo fiscal, com Nasajon e NFE.io) e em soluções com WordPress/PHP.
    TEXT
  )
  experience.save!

  education = profile.educations.find_or_initialize_by(
    institution: "Anhanguera",
    course: "Análise e Desenvolvimento de Sistemas"
  )
  education.assign_attributes(
    degree: "Tecnólogo",
    start_date: Date.new(2026, 1, 1),
    end_date: Date.new(2029, 1, 1),
    current: true,
    position: 1,
    description: <<~TEXT.strip
      Formação em Análise e Desenvolvimento de Sistemas, com ênfase em desenvolvimento de software, programação, banco de dados e engenharia de software.
    TEXT
  )
  education.save!

  skills_by_name = {}

  [
    # Backend
    { name: "Ruby", slug: "ruby", category: "Backend", icon: "ruby", position: 1 },
    { name: "Ruby on Rails", slug: "ruby-on-rails", category: "Backend", icon: "rails", position: 2 },
    { name: "PHP", slug: "php", category: "Backend", icon: "php", position: 3 },
    { name: "REST APIs", slug: "rest-apis", category: "Backend", icon: "api", position: 4 },
    { name: "SQL", slug: "sql", category: "Backend", icon: "sql", position: 5 },
    { name: "PostgreSQL", slug: "postgresql", category: "Backend", icon: "postgresql", position: 6 },
    { name: "Redis", slug: "redis", category: "Backend", icon: "redis", position: 7 },
    { name: "Sidekiq", slug: "sidekiq", category: "Backend", icon: "sidekiq", position: 8 },

    # Frontend
    { name: "Vue.js", slug: "vue-js", category: "Frontend", icon: "vue", position: 9 },
    { name: "Nuxt.js", slug: "nuxt-js", category: "Frontend", icon: "nuxt", position: 10 },
    { name: "JavaScript", slug: "javascript", category: "Frontend", icon: "javascript", position: 11 },
    { name: "TypeScript", slug: "typescript", category: "Frontend", icon: "typescript", position: 12 },
    { name: "HTML5", slug: "html5", category: "Frontend", icon: "html5", position: 13 },
    { name: "CSS3", slug: "css3", category: "Frontend", icon: "css3", position: 14 },
    { name: "Tailwind CSS", slug: "tailwind-css", category: "Frontend", icon: "tailwind-css", position: 15 },
    { name: "Bootstrap", slug: "bootstrap", category: "Frontend", icon: "bootstrap", position: 16 },

    # Testes e documentação
    { name: "RSpec", slug: "rspec", category: "Testes e documentação", icon: "rspec", position: 17 },
    { name: "Rswag", slug: "rswag", category: "Testes e documentação", icon: "rswag", position: 18 },
    { name: "OpenAPI", slug: "openapi", category: "Testes e documentação", icon: "openapi", position: 19 },
    { name: "Swagger", slug: "swagger", category: "Testes e documentação", icon: "swagger", position: 20 },

    # Integrações
    { name: "OpenAI API", slug: "openai-api", category: "Integrações", icon: "openai", position: 21 },
    { name: "APIs de terceiros", slug: "apis-de-terceiros", category: "Integrações", icon: "third-party-apis", position: 22 },
    { name: "Webhooks", slug: "webhooks", category: "Integrações", icon: "webhooks", position: 23 },
    { name: "PagBank", slug: "pagbank", category: "Integrações", icon: "pagbank", position: 24 },
    { name: "PayPal", slug: "paypal", category: "Integrações", icon: "paypal", position: 25 },
    { name: "Integrações fiscais", slug: "integracoes-fiscais", category: "Integrações", icon: "fiscal-integrations", position: 26 },
    { name: "Nasajon", slug: "nasajon", category: "Integrações", icon: "nasajon", position: 27 },
    { name: "NFE.io", slug: "nfe-io", category: "Integrações", icon: "nfe-io", position: 28 },
    { name: "Assinaturas recorrentes", slug: "assinaturas-recorrentes", category: "Integrações", icon: "recurring-subscriptions", position: 29 },

    # WordPress
    { name: "WordPress", slug: "wordpress", category: "WordPress", icon: "wordpress", position: 30 },

    # DevOps / ferramentas
    { name: "Docker", slug: "docker", category: "DevOps", icon: "docker", position: 31 },
    { name: "Docker Compose", slug: "docker-compose", category: "DevOps", icon: "docker-compose", position: 32 },
    { name: "Linux", slug: "linux", category: "DevOps", icon: "linux", position: 33 },
    { name: "Git", slug: "git", category: "DevOps", icon: "git", position: 34 },
    { name: "GitHub", slug: "github", category: "DevOps", icon: "github", position: 35 },
    { name: "GitLab", slug: "gitlab", category: "DevOps", icon: "gitlab", position: 36 },

    # Arquitetura / desenvolvimento
    { name: "MVC", slug: "mvc", category: "Arquitetura", icon: "mvc", position: 37 },
    { name: "Clean Code", slug: "clean-code", category: "Arquitetura", icon: "clean-code", position: 38 },
    { name: "i18n", slug: "i18n", category: "Arquitetura", icon: "i18n", position: 39 }
  ].each do |attributes|
    skill = Skill.find_or_initialize_by(slug: attributes[:slug])
    skill.assign_attributes(
      attributes.merge(
        profile: profile,
        level: nil,
        description: nil
      )
    )
    skill.save!
    skills_by_name[attributes[:name]] = skill
  end

  projects_data = [
    {
      name: "Plataforma de Gestão de Cidadania",
      slug: "plataforma-gestao-cidadania",
      short_description: "APIs e interface para gerenciamento de processos de cidadania italiana.",
      description: <<~TEXT.strip,
        Desenvolvimento de APIs RESTful em Ruby on Rails para gerenciamento de processos de cidadania italiana, incluindo modelagem de dados, relacionamentos entre processos, pedidos, status e estrutura familiar.

        Também houve desenvolvimento de funcionalidades no frontend com Vue.js e Nuxt.js. Foram implementados testes automatizados com RSpec e documentação de APIs com Rswag/OpenAPI.

        Houve integração com a OpenAI API para tradução de mensagens entre clientes brasileiros e advogados italianos.
      TEXT
      featured: true,
      position: 1,
      skill_names: [
        "Ruby",
        "Ruby on Rails",
        "PostgreSQL",
        "REST APIs",
        "RSpec",
        "Rswag",
        "OpenAPI",
        "OpenAI API",
        "Vue.js",
        "Nuxt.js",
        "JavaScript"
      ]
    },
    {
      name: "Plataforma de Gestão de Obras e Serviços",
      slug: "plataforma-gestao-obras-servicos",
      short_description: "Sistema para organizar obras, ordens de serviço e atividades.",
      description: <<~TEXT.strip,
        Sistema para gerenciamento de obras e ordens de serviço, permitindo organizar trabalhos, acompanhar atividades e centralizar informações relacionadas aos serviços.
      TEXT
      featured: true,
      position: 2,
      skill_names: [
        "Ruby",
        "Ruby on Rails",
        "PostgreSQL",
        "Vue.js",
        "JavaScript",
        "REST APIs"
      ]
    },
    {
      name: "Plataforma de E-commerce",
      slug: "plataforma-ecommerce",
      short_description: "Comércio eletrônico com pedidos, clientes e pagamentos.",
      description: <<~TEXT.strip,
        Aplicação de comércio eletrônico envolvendo produtos, pedidos, clientes e integrações externas. Inclui integração com PagBank e PayPal, pagamentos via cartão e boleto, e funcionalidades relacionadas a assinaturas recorrentes, como criação de planos, renovação e cancelamento.
      TEXT
      featured: false,
      position: 3,
      skill_names: [
        "Ruby",
        "Ruby on Rails",
        "PostgreSQL",
        "Vue.js",
        "JavaScript",
        "REST APIs",
        "PagBank",
        "PayPal"
      ]
    },
    {
      name: "Plataforma de Locação",
      slug: "plataforma-locacao",
      short_description: "Gestão de processos de locação de produtos.",
      description: <<~TEXT.strip,
        Sistema para gerenciamento de processos relacionados à locação de produtos, desenvolvido com Ruby on Rails e interface web.
      TEXT
      featured: false,
      position: 4,
      skill_names: [
        "Ruby",
        "Ruby on Rails",
        "PostgreSQL",
        "Vue.js",
        "JavaScript"
      ]
    },
    {
      name: "Plataforma de Conteúdo e Cursos",
      slug: "plataforma-conteudo-cursos",
      short_description: "Publicação de conteúdos e cursos com controle de acesso.",
      description: <<~TEXT.strip,
        Plataforma relacionada à publicação e gerenciamento de conteúdos e cursos, incluindo integração com sistemas de autenticação e gerenciamento de usuários. Também envolve controle de acesso a conteúdos e assinaturas recorrentes.
      TEXT
      featured: false,
      position: 5,
      skill_names: [
        "Ruby",
        "Ruby on Rails",
        "PostgreSQL",
        "WordPress",
        "REST APIs"
      ]
    },
    {
      name: "Sistema de Autenticação Centralizada",
      slug: "sistema-autenticacao-centralizada",
      short_description: "Autenticação e usuários compartilhados entre aplicações.",
      description: <<~TEXT.strip,
        Solução de autenticação centralizada e integração entre aplicações, permitindo compartilhar mecanismos de autenticação e gerenciamento de usuários entre diferentes sistemas.
      TEXT
      featured: false,
      position: 6,
      skill_names: [
        "Ruby",
        "Ruby on Rails",
        "REST APIs",
        "PHP",
        "WordPress"
      ]
    },
    {
      name: "Plugin de Integração WordPress",
      slug: "plugin-integracao-wordpress",
      short_description: "Plugin PHP para comunicação entre WordPress e APIs externas.",
      description: <<~TEXT.strip,
        Desenvolvimento de plugin WordPress em PHP integrado a uma API externa, permitindo comunicação entre o WordPress e sistemas externos.
      TEXT
      featured: false,
      position: 7,
      skill_names: [
        "PHP",
        "WordPress",
        "REST APIs",
        "Ruby on Rails"
      ]
    },
    {
      name: "Biblioteca de Integração de Autenticação",
      slug: "biblioteca-integracao-autenticacao",
      short_description: "Biblioteca Ruby para integração com autenticação externa.",
      description: <<~TEXT.strip,
        Desenvolvimento de uma biblioteca Ruby para facilitar a integração de aplicações com um sistema externo de autenticação, encapsulando funcionalidades comuns e simplificando sua utilização em diferentes projetos.
      TEXT
      featured: false,
      position: 8,
      skill_names: [
        "Ruby",
        "REST APIs"
      ]
    }
  ]

  desired_project_slugs = projects_data.map { |item| item[:slug] }

  projects_data.each do |attributes|
    project = profile.projects.find_by(slug: attributes[:slug])
    previous_slug = PROJECT_SLUG_ALIASES.key(attributes[:slug])
    project ||= profile.projects.find_by(slug: previous_slug) if previous_slug
    project ||= profile.projects.new(slug: attributes[:slug])

    project.assign_attributes(
      profile: profile,
      name: attributes[:name],
      slug: attributes[:slug],
      short_description: attributes[:short_description],
      description: attributes[:description],
      featured: attributes[:featured],
      position: attributes[:position],
      image_url: nil,
      github_url: nil,
      demo_url: nil,
      start_date: nil,
      end_date: nil
    )
    project.save!

    project.skills = attributes[:skill_names].map { |name| skills_by_name.fetch(name) }
  end

  profile.projects.where.not(slug: desired_project_slugs).find_each(&:destroy!)

  [
    {
      platform: "GitHub",
      username: "leonardobdms",
      url: "https://github.com/leonardobdms",
      icon: "github",
      position: 1
    },
    {
      platform: "LinkedIn",
      username: "leonardomartinsbd",
      url: "https://www.linkedin.com/in/leonardomartinsbd/",
      icon: "linkedin",
      position: 2
    }
  ].each do |attributes|
    social_link = profile.social_links.find_or_initialize_by(platform: attributes[:platform])
    social_link.assign_attributes(attributes)
    social_link.save!
  end
end
