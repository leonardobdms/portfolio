import { describe, expect, it } from "vitest"

import { SOCIAL_ICON_REGISTRY, resolveSocialIcon } from "@/lib/social-icons"

describe("resolveSocialIcon", () => {
  it("matches known platforms", () => {
    expect(resolveSocialIcon("GitHub")).toEqual(SOCIAL_ICON_REGISTRY.github)
    expect(resolveSocialIcon("linkedin")).toEqual(SOCIAL_ICON_REGISTRY.linkedin)
    expect(resolveSocialIcon("gitlab.com")).toEqual(SOCIAL_ICON_REGISTRY.gitlab)
    expect(resolveSocialIcon("Instagram")).toEqual(
      SOCIAL_ICON_REGISTRY.instagram,
    )
    expect(resolveSocialIcon("WhatsApp")).toEqual(SOCIAL_ICON_REGISTRY.whatsapp)
    expect(resolveSocialIcon("Twitter")).toEqual(SOCIAL_ICON_REGISTRY.x)
    expect(resolveSocialIcon("x")).toEqual(SOCIAL_ICON_REGISTRY.x)
  })

  it("falls back to the website icon", () => {
    expect(resolveSocialIcon("Mastodon")).toEqual(SOCIAL_ICON_REGISTRY.website)
  })
})
