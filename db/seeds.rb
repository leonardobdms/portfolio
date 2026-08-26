# frozen_string_literal: true

if Rails.env.local?
  Admin.create!(email: "admin@admin.com", password: "password@123")
end

profile = Profile.create!(
  name: "Leonardo Martins Bueno Dias",
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
  available_for_work: true,
  resume_url: "/documents/curriculo-leonardo-martins-bueno-dias.pdf"
)

profile.experiences.create!(
  role: "Desenvolvedor Full Stack",
  company: "Agência F12",
  employment_type: "PJ",
  location: "São Paulo, SP",
  start_date: Date.new(2023, 1, 1),
  end_date: Date.new(2026, 7, 31),
  description: <<~TEXT.strip
    Desenvolvimento, manutenção e evolução de aplicações web, com participação na implementação de novas funcionalidades, correções, melhorias, integrações e validações em ambiente de QA.

    A atuação envolveu diferentes contextos de negócio, incluindo e-commerce, gestão de obras, locação de produtos, publicação de conteúdo, processos fiscais, cidadania italiana, portais corporativos, autenticação centralizada e assinaturas recorrentes.

    O trabalho foi feito principalmente com Ruby on Rails e Vue.js, além de Nuxt.js quando o frontend exigia. Incluiu APIs RESTful, PostgreSQL, Redis, Sidekiq, Docker, testes com RSpec, documentação de APIs com Rswag/OpenAPI, webhooks e integrações com APIs de terceiros, incluindo OpenAI API, PagBank e PayPal. Também houve atuação em integrações fiscais (NFS-e, RPS, comunicação com prefeituras e automação de fluxo fiscal, com Nasajon e NFE.io) e em soluções com WordPress/PHP.
  TEXT
)

profile.educations.create!(
  institution: "Anhanguera",
  course: "Análise e Desenvolvimento de Sistemas",
  degree: "Tecnólogo",
  start_date: Date.new(2026, 1, 1),
  end_date: Date.new(2029, 1, 1),
  current: true,
  description: <<~TEXT.strip
    Formação em Análise e Desenvolvimento de Sistemas, com ênfase em desenvolvimento de software, programação, banco de dados e engenharia de software.
  TEXT
)

skills_by_name = {}
position = 0

{
  "Backend" => [ "Ruby", "Ruby on Rails", "PHP", "REST APIs", "SQL", "PostgreSQL", "Redis", "Sidekiq" ],
  "Frontend" => [ "Vue.js", "Nuxt.js", "JavaScript", "TypeScript", "HTML5", "CSS3", "Tailwind CSS", "Bootstrap" ],
  "Testes e documentação" => [ "RSpec", "Rswag", "OpenAPI", "Swagger" ],
  "Integrações" => [
    "OpenAI API", "APIs de terceiros", "Webhooks", "PagBank", "PayPal",
    "Integrações fiscais", "Nasajon", "NFE.io", "Assinaturas recorrentes"
  ],
  "WordPress" => [ "WordPress" ],
  "DevOps" => [ "Docker", "Docker Compose", "Linux", "Git", "GitHub", "GitLab" ],
  "Arquitetura" => [ "MVC", "Clean Code", "i18n" ]
}.each do |category, names|
  names.each do |name|
    slug = name.parameterize
    skills_by_name[name] = profile.skills.create!(
      name:,
      category:,
      slug:,
      icon: slug,
      position: position += 1
    )
  end
end

[
  {
    name: "Plataforma de Gestão de Cidadania",
    short_description: "APIs e interface para gerenciamento de processos de cidadania italiana.",
    featured: true,
    skills: [ "Ruby", "Ruby on Rails", "PostgreSQL", "REST APIs", "RSpec", "Rswag", "OpenAPI", "OpenAI API", "Vue.js", "Nuxt.js", "JavaScript" ],
    description: <<~TEXT.strip
      Desenvolvimento de APIs RESTful em Ruby on Rails para gerenciamento de processos de cidadania italiana, incluindo modelagem de dados, relacionamentos entre processos, pedidos, status e estrutura familiar.

      Também houve desenvolvimento de funcionalidades no frontend com Vue.js e Nuxt.js. Foram implementados testes automatizados com RSpec e documentação de APIs com Rswag/OpenAPI.

      Houve integração com a OpenAI API para tradução de mensagens entre clientes brasileiros e advogados italianos.
    TEXT
  },
  {
    name: "Plataforma de Gestão de Obras e Serviços",
    short_description: "Sistema para organizar obras, ordens de serviço e atividades.",
    featured: true,
    skills: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript", "REST APIs" ],
    description: <<~TEXT.strip
      Sistema para gerenciamento de obras e ordens de serviço, permitindo organizar trabalhos, acompanhar atividades e centralizar informações relacionadas aos serviços.
    TEXT
  },
  {
    name: "Plataforma de E-commerce",
    short_description: "Comércio eletrônico com pedidos, clientes e pagamentos.",
    skills: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript", "REST APIs", "PagBank", "PayPal" ],
    description: <<~TEXT.strip
      Aplicação de comércio eletrônico envolvendo produtos, pedidos, clientes e integrações externas. Inclui integração com PagBank e PayPal, pagamentos via cartão e boleto, e funcionalidades relacionadas a assinaturas recorrentes, como criação de planos, renovação e cancelamento.
    TEXT
  },
  {
    name: "Plataforma de Locação",
    short_description: "Gestão de processos de locação de produtos.",
    skills: [ "Ruby", "Ruby on Rails", "PostgreSQL", "Vue.js", "JavaScript" ],
    description: <<~TEXT.strip
      Sistema para gerenciamento de processos relacionados à locação de produtos, desenvolvido com Ruby on Rails e interface web.
    TEXT
  },
  {
    name: "Plataforma de Conteúdo e Cursos",
    short_description: "Publicação de conteúdos e cursos com controle de acesso.",
    skills: [ "Ruby", "Ruby on Rails", "PostgreSQL", "WordPress", "REST APIs" ],
    description: <<~TEXT.strip
      Plataforma relacionada à publicação e gerenciamento de conteúdos e cursos, incluindo integração com sistemas de autenticação e gerenciamento de usuários. Também envolve controle de acesso a conteúdos e assinaturas recorrentes.
    TEXT
  },
  {
    name: "Sistema de Autenticação Centralizada",
    short_description: "Autenticação e usuários compartilhados entre aplicações.",
    skills: [ "Ruby", "Ruby on Rails", "REST APIs", "PHP", "WordPress" ],
    description: <<~TEXT.strip
      Solução de autenticação centralizada e integração entre aplicações, permitindo compartilhar mecanismos de autenticação e gerenciamento de usuários entre diferentes sistemas.
    TEXT
  },
  {
    name: "Plugin de Integração WordPress",
    short_description: "Plugin PHP para comunicação entre WordPress e APIs externas.",
    skills: [ "PHP", "WordPress", "REST APIs", "Ruby on Rails" ],
    description: <<~TEXT.strip
      Desenvolvimento de plugin WordPress em PHP integrado a uma API externa, permitindo comunicação entre o WordPress e sistemas externos.
    TEXT
  },
  {
    name: "Biblioteca de Integração de Autenticação",
    short_description: "Biblioteca Ruby para integração com autenticação externa.",
    skills: [ "Ruby", "REST APIs" ],
    description: <<~TEXT.strip
      Desenvolvimento de uma biblioteca Ruby para facilitar a integração de aplicações com um sistema externo de autenticação, encapsulando funcionalidades comuns e simplificando sua utilização em diferentes projetos.
    TEXT
  }
].each_with_index do |attributes, index|
  project = profile.projects.create!(
    name: attributes[:name],
    slug: attributes[:name].parameterize,
    short_description: attributes[:short_description],
    description: attributes[:description],
    featured: attributes.fetch(:featured, false),
    position: index + 1
  )
  project.skills = attributes[:skills].map { |name| skills_by_name.fetch(name) }
end

profile.social_links.create!(
  platform: "GitHub",
  username: "leonardobdms",
  url: profile.github_url,
  icon: "github",
  position: 1
)
profile.social_links.create!(
  platform: "LinkedIn",
  username: "leonardomartinsbd",
  url: profile.linkedin_url,
  icon: "linkedin",
  position: 2
)

[
  {
    name: "Boas vindas à Aceleração Santander - Cibersegurança do Zero à Prática",
    issuer: "Santander & DIO",
    issued_at: Date.new(2026, 8, 13),
    credential_id: "7SDOROPI",
    description: "Carga horária de 1 hora."
  },
  {
    name: "Aceleração Santander - Cibersegurança do Zero à Prática",
    issuer: "Santander & DIO",
    issued_at: Date.new(2026, 8, 14),
    credential_id: "BG4NANUL",
    description: "Carga horária de 2 horas."
  },
  {
    name: "Segurança e Boas Práticas em Projetos Feitos com Vibe Code",
    issuer: "Digital Innovation One (DIO)",
    issued_at: Date.new(2026, 8, 14),
    credential_id: "HVEJM1IH",
    description: "Carga horária de 1 hora."
  },
  {
    name: "Aceleração Santander - Boas Práticas de Segurança em Vibe Coding",
    issuer: "Santander & DIO",
    issued_at: Date.new(2026, 8, 14),
    credential_id: "YJRPKNKW",
    description: "Carga horária de 2 horas."
  },
  {
    name: "Fundamentos da IA Moderna: Machine Learning, LLMs, IA Generativa e Agentes",
    issuer: "Digital Innovation One (DIO)",
    issued_at: Date.new(2026, 8, 24),
    credential_id: "5D9P5TFZ",
    description: "Carga horária de 2 horas."
  },
  {
    name: "Boas vindas ao Bootcamp Itaú - Java com Inteligência Artificial",
    issuer: "Itaú & DIO",
    issued_at: Date.new(2026, 8, 24),
    credential_id: "UPU9IKTQ",
    description: "Carga horária de 1 hora."
  }
].each_with_index do |attributes, index|
  credential_id = attributes.fetch(:credential_id)
  profile.certifications.create!(
    name: attributes[:name],
    issuer: attributes[:issuer],
    issued_at: attributes[:issued_at],
    credential_id:,
    credential_url: "https://www.dio.me/certificate/#{credential_id}/share",
    description: attributes[:description],
    position: index + 1
  )
end
