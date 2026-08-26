import { describe, expect, it } from "vitest"

import { SKILL_ICON_REGISTRY, resolveSkillIcon } from "@/lib/skill-icons"

describe("resolveSkillIcon", () => {
  it("returns a registered brand icon", () => {
    expect(resolveSkillIcon("ruby")).toEqual(SKILL_ICON_REGISTRY.ruby)
  })

  it("falls back to the category icon", () => {
    const icon = resolveSkillIcon("unknown-tool", "Backend")

    expect(icon.type).toBe("lucide")
  })

  it("falls back to a generic icon", () => {
    const icon = resolveSkillIcon("unknown-tool")

    expect(icon.type).toBe("lucide")
  })
})
