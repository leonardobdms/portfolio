import laptopRails from '../assets/images/laptop-rails.jpg'
import rubyModel from '../assets/images/ruby-model.jpg'
import vueEditor from '../assets/images/still-vue-editor.jpg'
import apiTerminal from '../assets/images/still-api-terminal.jpg'
import postgresScreen from '../assets/images/still-postgres.jpg'
import gitTerminal from '../assets/images/still-git-terminal.jpg'

export interface Still {
  src: string
  width: number
  height: number
  altKey:
    | 'media.hero'
    | 'media.about'
    | 'media.vue'
    | 'media.api'
    | 'media.postgres'
    | 'media.git'
    | 'media.project'
}

export const HERO_STILL: Still = {
  src: laptopRails,
  width: 1920,
  height: 1080,
  altKey: 'media.hero',
}

export const ABOUT_STILL: Still = {
  src: rubyModel,
  width: 1600,
  height: 1200,
  altKey: 'media.about',
}

export const CONTACT_STILL: Still = {
  src: gitTerminal,
  width: 1920,
  height: 1080,
  altKey: 'media.git',
}

export const ACCORDION_STILLS: Still[] = [
  { src: vueEditor, width: 1920, height: 1080, altKey: 'media.vue' },
  { src: apiTerminal, width: 1200, height: 1600, altKey: 'media.api' },
  { src: postgresScreen, width: 1600, height: 1200, altKey: 'media.postgres' },
]

const PROJECT_STILLS: Record<string, Still> = {
  civitapro: { src: apiTerminal, width: 1200, height: 1600, altKey: 'media.project' },
  'arruma-la': { src: laptopRails, width: 1920, height: 1080, altKey: 'media.project' },
  'aluguel-legal': { src: vueEditor, width: 1920, height: 1080, altKey: 'media.project' },
  embalepack: { src: postgresScreen, width: 1600, height: 1200, altKey: 'media.project' },
  'ilos-prime': { src: rubyModel, width: 1600, height: 1200, altKey: 'media.project' },
  'ilos-e-commerce': { src: apiTerminal, width: 1200, height: 1600, altKey: 'media.project' },
  'ilos-cas': { src: gitTerminal, width: 1920, height: 1080, altKey: 'media.project' },
  'ilos-cas-auth': { src: vueEditor, width: 1920, height: 1080, altKey: 'media.project' },
  'ilos-cas-auth-gem': { src: rubyModel, width: 1600, height: 1200, altKey: 'media.project' },
}

export function stillForProject(slug: string): Still {
  return PROJECT_STILLS[slug] ?? HERO_STILL
}
