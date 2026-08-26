import {
  Container,
  FlaskConical,
  Layout,
  Plug,
  Server,
  Shapes,
} from "lucide-vue-next"
import {
  siBootstrap,
  siCss,
  siDocker,
  siGit,
  siGithub,
  siGitlab,
  siHtml5,
  siJavascript,
  siLinux,
  siMysql,
  siNuxt,
  siOpenapiinitiative,
  siPaypal,
  siPhp,
  siPostgresql,
  siRedis,
  siRuby,
  siRubyonrails,
  siSidekiq,
  siSwagger,
  siTailwindcss,
  siTypescript,
  siVuedotjs,
  siWordpress,
} from "simple-icons"
import type { Component } from "vue"

export type BrandIconData = {
  type: "brand"
  path: string
  hex: string
  title: string
}

export type LucideIconData = {
  type: "lucide"
  component: Component
}

export type SkillIconData = BrandIconData | LucideIconData

function brand(icon: {
  path: string
  hex: string
  title: string
}): BrandIconData {
  return {
    type: "brand",
    path: icon.path,
    hex: icon.hex,
    title: icon.title,
  }
}

function lucide(component: Component): LucideIconData {
  return { type: "lucide", component }
}

/** Explicit map of skill.icon slugs from the database to icon data. */
export const SKILL_ICON_REGISTRY: Record<string, SkillIconData> = {
  ruby: brand(siRuby),
  "ruby-on-rails": brand(siRubyonrails),
  php: brand(siPhp),
  sql: brand(siMysql),
  postgresql: brand(siPostgresql),
  redis: brand(siRedis),
  sidekiq: brand(siSidekiq),
  "vue-js": brand(siVuedotjs),
  "nuxt-js": brand(siNuxt),
  javascript: brand(siJavascript),
  typescript: brand(siTypescript),
  html5: brand(siHtml5),
  css3: brand(siCss),
  "tailwind-css": brand(siTailwindcss),
  bootstrap: brand(siBootstrap),
  rspec: lucide(FlaskConical),
  rswag: lucide(FlaskConical),
  openapi: brand(siOpenapiinitiative),
  swagger: brand(siSwagger),
  "openai-api": lucide(Plug),
  "apis-de-terceiros": lucide(Plug),
  webhooks: lucide(Plug),
  pagbank: lucide(Plug),
  paypal: brand(siPaypal),
  "integracoes-fiscais": lucide(Plug),
  nasajon: lucide(Plug),
  "nfe-io": lucide(Plug),
  "assinaturas-recorrentes": lucide(Plug),
  wordpress: brand(siWordpress),
  docker: brand(siDocker),
  "docker-compose": brand(siDocker),
  linux: brand(siLinux),
  git: brand(siGit),
  github: brand(siGithub),
  gitlab: brand(siGitlab),
  mvc: lucide(Shapes),
  "clean-code": lucide(Shapes),
  i18n: lucide(Shapes),
  "rest-apis": lucide(Server),
}

export const CATEGORY_FALLBACK_ICONS: Record<string, Component> = {
  Backend: Server,
  Frontend: Layout,
  "Testes e documentação": FlaskConical,
  Integrações: Plug,
  WordPress: Container,
  DevOps: Container,
  Arquitetura: Shapes,
}

export function resolveSkillIcon(
  icon: string,
  category?: string,
): SkillIconData {
  const registered = SKILL_ICON_REGISTRY[icon]
  if (registered) return registered

  if (category && CATEGORY_FALLBACK_ICONS[category]) {
    return lucide(CATEGORY_FALLBACK_ICONS[category])
  }

  return lucide(Shapes)
}

export const SEEDED_SKILL_ICONS = Object.keys(SKILL_ICON_REGISTRY)
