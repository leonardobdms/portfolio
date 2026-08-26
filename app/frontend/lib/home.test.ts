import { describe, expect, it } from "vitest"

import {
  earliestExperienceYear,
  featuredProjects,
  formatDateRange,
  formatEducationRange,
  formatMonthYear,
  formatYear,
  hasContact,
  hasResume,
  isSpecialtySkill,
  navItems,
  profileSocials,
  skillsByCategory,
  specialtySkills,
  splitParagraphs,
  whatsappHref,
} from "@/lib/home"
import { SEEDED_SKILL_ICONS } from "@/lib/skill-icons"
import type { Education, Experience, Profile, Project, Skill } from "@/types"

const skill = (overrides: Partial<Skill> = {}): Skill =>
  ({
    id: 1,
    slug: "ruby",
    category: "Backend",
    icon: "ruby",
    name: "Ruby",
    ...overrides,
  }) as Skill

const project = (overrides: Partial<Project> = {}): Project =>
  ({
    id: 1,
    featured: true,
    slug: "demo",
    name: "Demo",
    ...overrides,
  }) as Project

const profile = (overrides: Partial<Profile> = {}): Profile =>
  ({
    skills: [skill()],
    experiences: [],
    projects: [project()],
    bio: "Bio",
    certifications: [{ id: 1, name: "Cert" }],
    educations: [],
    email: "test@example.com",
    phone: null,
    social_links: [],
    github_url: null,
    linkedin_url: null,
    website_url: null,
    resume_url: null,
    ...overrides,
  }) as unknown as Profile

describe("home helpers", () => {
  it("filters featured projects", () => {
    expect(
      featuredProjects([
        project({ featured: true }),
        project({ id: 2, featured: false, slug: "other" }),
      ]),
    ).toHaveLength(1)
  })

  it("resolves specialty skills in a stable order", () => {
    const skills = [
      skill({ id: 2, slug: "vue-js", name: "Vue" }),
      skill({ id: 3, slug: "php", name: "PHP" }),
      skill({ id: 1, slug: "ruby-on-rails", name: "Rails" }),
      skill(),
    ]

    expect(specialtySkills(skills).map((item) => item.slug)).toEqual([
      "ruby",
      "ruby-on-rails",
      "vue-js",
    ])
    expect(specialtySkills([skill({ slug: "php" })])).toEqual([])
    expect(isSpecialtySkill(skill())).toBe(true)
    expect(isSpecialtySkill(skill({ slug: "php" }))).toBe(false)
  })

  it("groups skills by category", () => {
    const groups = skillsByCategory([
      skill({ id: 1, category: "Backend" }),
      skill({ id: 2, slug: "vue-js", category: "Frontend" }),
      skill({ id: 3, slug: "rspec", category: "Backend" }),
    ])

    expect(groups).toEqual([
      {
        category: "Backend",
        items: [
          expect.objectContaining({ slug: "ruby" }),
          expect.objectContaining({ slug: "rspec" }),
        ],
      },
      {
        category: "Frontend",
        items: [expect.objectContaining({ slug: "vue-js" })],
      },
    ])
  })

  it("prefers explicit social links over profile fallbacks", () => {
    expect(
      profileSocials(
        profile({
          social_links: [
            {
              platform: "Mastodon",
              url: "https://mastodon.social/@ada",
              icon: "mastodon",
            },
          ],
          github_url: "https://github.com/ignored",
        } as Partial<Profile>),
      ),
    ).toEqual([
      {
        label: "Mastodon",
        url: "https://mastodon.social/@ada",
        icon: "mastodon",
      },
    ])
  })

  it("builds fallback socials from profile URLs", () => {
    expect(
      profileSocials(
        profile({
          social_links: [],
          github_url: "https://github.com/ada",
          linkedin_url: "https://linkedin.com/in/ada",
          website_url: "https://ada.dev",
        }),
      ),
    ).toEqual([
      { label: "GitHub", url: "https://github.com/ada", icon: "github" },
      {
        label: "LinkedIn",
        url: "https://linkedin.com/in/ada",
        icon: "linkedin",
      },
      { label: "Website", url: "https://ada.dev", icon: "website" },
    ])
  })

  it("detects contact and resume availability", () => {
    expect(hasContact(profile({ email: null, social_links: [] }))).toBe(false)
    expect(hasContact(profile({ email: "a@b.c" }))).toBe(true)
    expect(hasResume(profile({ resume_url: null }))).toBe(false)
    expect(
      hasResume(profile({ resume_url: "https://example.com/cv.pdf" })),
    ).toBe(true)
  })

  it("builds nav items from visible sections", () => {
    expect(navItems(profile()).map((item) => item.key)).toEqual([
      "skills",
      "projects",
      "about",
      "certifications",
      "contact",
    ])

    expect(
      navItems(
        profile({
          skills: [],
          projects: [],
          bio: null,
          certifications: [],
          email: null,
          social_links: [],
          experiences: [{ id: 1 }] as never,
        }),
      ).map((item) => item.key),
    ).toEqual(["experience"])
  })

  it("splits paragraphs by blank lines or sentences", () => {
    expect(splitParagraphs("One.\n\nTwo.")).toEqual(["One.", "Two."])
    expect(splitParagraphs("One. Two.")).toEqual(["One.", "Two."])
    expect(splitParagraphs("   ")).toEqual([])
  })

  it("builds WhatsApp links from formatted phone numbers", () => {
    expect(whatsappHref("+55 (11) 94475-1977")).toBe(
      "https://wa.me/5511944751977",
    )
  })

  it("formats dates and ranges", () => {
    expect(formatMonthYear("2022-01-15", "en")).toMatch(/January 2022/)
    expect(formatMonthYear("not-a-date", "en")).toBe("not-a-date")
    expect(formatYear("2018-02-01", "en")).toBe("2018")
    expect(formatYear("bad", "en")).toBe("bad")
    expect(
      formatDateRange("2022-01-01", "2023-06-01", false, "en", "Present"),
    ).toMatch(/January 2022 - June 2023/)
    expect(formatDateRange("2022-01-01", null, true, "en", "Present")).toMatch(
      /January 2022 - Present/,
    )
    expect(formatDateRange("2022-01-01", null, false, "en", "Present")).toMatch(
      /January 2022 - Present/,
    )
  })

  it("formats education ranges", () => {
    const education = {
      start_date: "2018-02-01",
      end_date: "2022-12-01",
      current: false,
    } as Education

    expect(formatEducationRange(education, "en", "Present")).toBe("2018 - 2022")
    expect(
      formatEducationRange(
        { ...education, current: true, end_date: null },
        "en",
        "Present",
      ),
    ).toBe("2018 - Present")
    expect(
      formatEducationRange(
        { ...education, current: false, end_date: null },
        "en",
        "Present",
      ),
    ).toBe("2018 - Present")
  })

  it("finds the earliest experience year", () => {
    const experiences = [
      { start_date: "2020-01-01" },
      { start_date: "2018-06-01" },
      { start_date: "2022-01-01" },
    ] as Experience[]

    expect(earliestExperienceYear(experiences, "en")).toBe("2018")
    expect(earliestExperienceYear([], "en")).toBeNull()
    expect(
      earliestExperienceYear([{ start_date: "bad" }] as Experience[], "en"),
    ).toBeNull()
  })
})

describe("skill icon registry", () => {
  it("includes seeded icon slugs", () => {
    expect(SEEDED_SKILL_ICONS.length).toBeGreaterThan(20)
    expect(SEEDED_SKILL_ICONS).toContain("ruby-on-rails")
  })
})
