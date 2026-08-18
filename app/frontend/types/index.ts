export type SkillLevel = 'featured' | 'core' | 'catalog'

export interface NamedIcon {
  name: string
  icon: string
}
export type ProjectIcon =
  | 'landmark'
  | 'hammer'
  | 'store'
  | 'building-2'
  | 'truck'
  | 'newspaper'
  | 'shield-check'
  | 'puzzle'
  | 'gem'
export type ContactKind = 'github' | 'linkedin' | 'email' | 'other'

export interface ProfilePayload {
  name: string
  shortName: string
  headline: string
  intro: string
  about: string[]
  highlights: NamedIcon[]
  contactTitle: string
  contactText: string
  seoDescription: string
  siteUrl: string
  copyrightYear: number
}

export interface SkillItem {
  id: number
  name: string
  icon: string
  level: SkillLevel
}

export interface ContactItem {
  id: number
  label: string
  kind: ContactKind
  href: string
  external: boolean
}

export interface ExperienceItem {
  id: number
  role: string
  company?: string | null
  period: string
  description: string
  technologies: NamedIcon[]
  url: string
}

export interface ProjectItem {
  id: number
  name: string
  slug: string
  summary: string
  description: string[]
  role: string
  icon: ProjectIcon
  url: string
  github: string
  technologies: NamedIcon[]
  highlights: string[]
  featured: boolean
}

export interface PortfolioPayload {
  profile: ProfilePayload
  skills: SkillItem[]
  contacts: ContactItem[]
  experiences: ExperienceItem[]
  projects: ProjectItem[]
}

export interface PageProps {
  portfolio?: PortfolioPayload
  locale: string
  errors?: Record<string, string>
  [key: string]: unknown
}

export interface NavItem {
  labelKey: 'nav.about' | 'nav.experience' | 'nav.projects' | 'nav.skills' | 'nav.contact'
  href: string
}

export const NAV_ITEMS: NavItem[] = [
  { labelKey: 'nav.about', href: '#sobre' },
  { labelKey: 'nav.experience', href: '#experiencia' },
  { labelKey: 'nav.projects', href: '#projetos' },
  { labelKey: 'nav.skills', href: '#tecnologias' },
  { labelKey: 'nav.contact', href: '#contato' },
]
