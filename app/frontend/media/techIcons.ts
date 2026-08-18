import {
  siChatbot,
  siGit,
  siGithub,
  siGitlab,
  siJavascript,
  siJson,
  siKeycloak,
  siOpenapiinitiative,
  siPagseguro,
  siPaypal,
  siPhp,
  siPostgresql,
  siRuby,
  siRubyonrails,
  siSwagger,
  siTestinglibrary,
  siVuedotjs,
  siWordpress,
} from 'simple-icons'

export interface TechGlyph {
  title: string
  path: string
}

const ICONS: Record<string, TechGlyph> = {
  chatbot: siChatbot,
  git: siGit,
  github: siGithub,
  gitlab: siGitlab,
  javascript: siJavascript,
  json: siJson,
  keycloak: siKeycloak,
  openapiinitiative: siOpenapiinitiative,
  pagseguro: siPagseguro,
  paypal: siPaypal,
  php: siPhp,
  postgresql: siPostgresql,
  ruby: siRuby,
  rubyonrails: siRubyonrails,
  swagger: siSwagger,
  testinglibrary: siTestinglibrary,
  vuedotjs: siVuedotjs,
  wordpress: siWordpress,
}

export function techGlyph(slug: string): TechGlyph | null {
  return ICONS[slug] ?? null
}
