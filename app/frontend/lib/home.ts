import type {
  Education,
  Experience,
  Profile,
  Project,
  Skill,
  SocialLink,
} from "@/types"

export const SPECIALTY_SLUGS = ["ruby", "ruby-on-rails", "vue-js"] as const

export type NavKey =
  "skills" | "experience" | "projects" | "about" | "certifications" | "contact"

export type NavItem = {
  key: NavKey
  href: string
}

export type ProfileSocial = {
  label: string
  url: string
  icon: string | null
}

export function featuredProjects(projects: Project[]): Project[] {
  return projects.filter((project) => project.featured)
}

export function specialtySkills(skills: Skill[]): Skill[] {
  return SPECIALTY_SLUGS.flatMap((slug) => {
    const skill = skills.find((item) => item.slug === slug)
    return skill ? [skill] : []
  })
}

export function isSpecialtySkill(skill: Skill): boolean {
  return (SPECIALTY_SLUGS as readonly string[]).includes(skill.slug)
}

export function skillsByCategory(
  skills: Skill[],
): Array<{ category: string; items: Skill[] }> {
  const groups = new Map<string, Skill[]>()

  for (const skill of skills) {
    const items = groups.get(skill.category) ?? []
    items.push(skill)
    groups.set(skill.category, items)
  }

  return [...groups.entries()].map(([category, items]) => ({
    category,
    items,
  }))
}

export function profileSocials(profile: Profile): ProfileSocial[] {
  if (profile.social_links.length > 0) {
    return profile.social_links.map((link: SocialLink) => ({
      label: link.platform,
      url: link.url,
      icon: link.icon,
    }))
  }

  const links: ProfileSocial[] = []

  if (profile.github_url) {
    links.push({
      label: "GitHub",
      url: profile.github_url,
      icon: "github",
    })
  }

  if (profile.linkedin_url) {
    links.push({
      label: "LinkedIn",
      url: profile.linkedin_url,
      icon: "linkedin",
    })
  }

  if (profile.website_url) {
    links.push({
      label: "Website",
      url: profile.website_url,
      icon: "website",
    })
  }

  return links
}

export function hasContact(profile: Profile): boolean {
  return Boolean(
    profile.email || profile.phone || profileSocials(profile).length > 0,
  )
}

export function hasResume(profile: Profile): boolean {
  return Boolean(profile.resume_url)
}

export function navItems(profile: Profile): NavItem[] {
  const items: NavItem[] = []

  if (profile.skills.length > 0) {
    items.push({ key: "skills", href: "#skills" })
  }

  if (profile.experiences.length > 0) {
    items.push({ key: "experience", href: "#experience" })
  }

  if (featuredProjects(profile.projects).length > 0) {
    items.push({ key: "projects", href: "#projects" })
  }

  if (profile.bio) {
    items.push({ key: "about", href: "#about" })
  }

  if (profile.certifications.length > 0) {
    items.push({ key: "certifications", href: "#certifications" })
  }

  if (hasContact(profile)) {
    items.push({ key: "contact", href: "#contact" })
  }

  return items
}

export function splitParagraphs(text: string): string[] {
  const blocks = text
    .split(/\n\s*\n/)
    .map((block) => block.trim())
    .filter(Boolean)

  if (blocks.length > 1) return blocks

  return text
    .split(/(?<=\.)\s+/)
    .map((block) => block.trim())
    .filter(Boolean)
}

export function whatsappHref(phone: string): string {
  const digits = phone.replace(/\D/g, "")
  return `https://wa.me/${digits}`
}

function parseDate(value: string): Date | null {
  const match = /^(\d{4})-(\d{2})-(\d{2})/.exec(value)
  if (!match) return null

  const year = Number(match[1])
  const month = Number(match[2])
  const day = Number(match[3])

  return new Date(year, month - 1, day)
}

export function formatMonthYear(value: string, locale: string): string {
  const date = parseDate(value)
  if (!date) return value

  return new Intl.DateTimeFormat(locale, {
    month: "long",
    year: "numeric",
  }).format(date)
}

export function formatYear(value: string, locale: string): string {
  const date = parseDate(value)
  if (!date) return value

  return new Intl.DateTimeFormat(locale, { year: "numeric" }).format(date)
}

export function formatDateRange(
  startDate: string,
  endDate: string | null,
  current: boolean,
  locale: string,
  presentLabel: string,
): string {
  const startLabel = formatMonthYear(startDate, locale)

  if (current || !endDate) {
    return `${startLabel} - ${presentLabel}`
  }

  return `${startLabel} - ${formatMonthYear(endDate, locale)}`
}

export function formatEducationRange(
  education: Education,
  locale: string,
  presentLabel: string,
): string {
  const startLabel = formatYear(education.start_date, locale)

  if (education.current || !education.end_date) {
    return `${startLabel} - ${presentLabel}`
  }

  return `${startLabel} - ${formatYear(education.end_date, locale)}`
}

export function earliestExperienceYear(
  experiences: Experience[],
  locale: string,
): string | null {
  const startDates = experiences
    .map((experience) => parseDate(experience.start_date))
    .filter((date): date is Date => date !== null)

  if (startDates.length === 0) return null

  const earliest = startDates.reduce((min, date) => (date < min ? date : min))

  return new Intl.DateTimeFormat(locale, { year: "numeric" }).format(earliest)
}
