import { describe, expect, it } from "vitest"

import { featuredProjects, hasResume, navItems, whatsappHref } from "@/lib/home"
import { SEEDED_SKILL_ICONS } from "@/lib/skill-icons"
import type { Profile } from "@/types"

const profile = {
  skills: [
    { id: 1, slug: "ruby", category: "Backend", icon: "ruby", name: "Ruby" },
  ],
  experiences: [],
  projects: [{ id: 1, featured: true, slug: "demo", name: "Demo" }],
  bio: "Bio",
  certifications: [],
  educations: [],
  email: "test@example.com",
  social_links: [],
} as unknown as Profile

describe("home helpers", () => {
  it("filters featured projects", () => {
    expect(
      featuredProjects(profile.projects as Profile["projects"]),
    ).toHaveLength(1)
  })

  it("builds nav items from profile data", () => {
    const items = navItems(profile)
    expect(items.map((item) => item.key)).toEqual([
      "skills",
      "projects",
      "about",
      "contact",
    ])
  })

  it("detects resume availability", () => {
    expect(hasResume({ ...profile, resume_url: null })).toBe(false)
    expect(
      hasResume({ ...profile, resume_url: "https://example.com/cv.pdf" }),
    ).toBe(true)
  })

  it("builds WhatsApp links from formatted phone numbers", () => {
    expect(whatsappHref("+55 (11) 94475-1977")).toBe(
      "https://wa.me/5511944751977",
    )
  })
})

describe("skill icon registry", () => {
  it("includes seeded icon slugs", () => {
    expect(SEEDED_SKILL_ICONS.length).toBeGreaterThan(20)
    expect(SEEDED_SKILL_ICONS).toContain("ruby-on-rails")
  })
})
