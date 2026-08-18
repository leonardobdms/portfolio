# frozen_string_literal: true

class Profile < ApplicationRecord
  validates :name, :short_name, :headline, :intro, presence: true
  validates :copyright_year, numericality: { greater_than: 2000 }

  validate :only_one_profile, on: :create

  def self.current
    order(:id).first || create_default!
  end

  def about_paragraphs
    about.to_s.split(/\n{2,}/).map(&:strip).compact_blank
  end

  def highlights_list
    Array(highlights).map(&:strip).compact_blank
  end

  def self.create_default!
    create!(
      name: "Leonardo Martins Bueno Dias",
      short_name: "Leonardo",
      headline: "Desenvolvedor Full Stack",
      intro: "Desenvolvedor com experiência em Ruby on Rails e Vue.js, criando aplicações web, APIs e soluções escaláveis.",
      about: [
        "Sou desenvolvedor Full Stack com experiência no desenvolvimento de aplicações web utilizando principalmente Ruby on Rails e Vue.js. Tenho experiência na construção de APIs, integrações com serviços externos, sistemas administrativos e aplicações voltadas para diferentes necessidades de negócio.",
        "Busco escrever código organizado, testável e de fácil manutenção, sempre procurando entender o problema antes de definir a solução."
      ].join("\n\n"),
      highlights: [ "Ruby on Rails", "Vue.js", "Full Stack" ],
      contact_title: "Vamos conversar?",
      contact_text: "Estou aberto a novas oportunidades e projetos.",
      seo_description: "Portfólio de Leonardo Martins Bueno Dias, desenvolvedor Full Stack com experiência em Ruby on Rails, Vue.js, APIs e aplicações web.",
      site_url: "",
      copyright_year: 2026
    )
  end

  private

  def only_one_profile
    errors.add(:base, :already_exists) if Profile.exists?
  end
end
