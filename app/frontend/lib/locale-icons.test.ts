import { describe, expect, it } from "vitest"

import { LOCALE_ICON_REGISTRY } from "@/lib/locale-icons"

describe("locale icons", () => {
  it("defines flags for every supported locale", () => {
    expect(Object.keys(LOCALE_ICON_REGISTRY).sort()).toEqual(["en", "pt-BR"])
    expect(LOCALE_ICON_REGISTRY.en.paths.length).toBeGreaterThan(0)
    expect(LOCALE_ICON_REGISTRY["pt-BR"].paths.length).toBeGreaterThan(0)
  })
})
