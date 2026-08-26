import { describe, expect, it } from "vitest"

import {
  DEFAULT_THEME,
  isSupportedTheme,
  normalizeTheme,
  themeSwitchPath,
} from "@/lib/theme"

describe("theme helpers", () => {
  it("accepts supported themes", () => {
    expect(isSupportedTheme("dark")).toBe(true)
    expect(isSupportedTheme("light")).toBe(true)
    expect(isSupportedTheme("neon")).toBe(false)
  })

  it("normalizes unknown values to the default theme", () => {
    expect(normalizeTheme("light")).toBe("light")
    expect(normalizeTheme("neon")).toBe(DEFAULT_THEME)
    expect(normalizeTheme(null)).toBe(DEFAULT_THEME)
  })

  it("builds the theme switch path", () => {
    expect(themeSwitchPath("light")).toContain("theme=light")
  })
})
