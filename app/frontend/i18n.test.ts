import { describe, expect, it } from "vitest"

import {
  DEFAULT_LOCALE,
  createI18nInstance,
  isSupportedLocale,
  localeFromPage,
  localeSwitchPath,
  normalizeLocale,
} from "@/i18n"

describe("i18n helpers", () => {
  it("accepts supported locales", () => {
    expect(isSupportedLocale("en")).toBe(true)
    expect(isSupportedLocale("pt-BR")).toBe(true)
    expect(isSupportedLocale("fr")).toBe(false)
  })

  it("normalizes unknown values to the default locale", () => {
    expect(normalizeLocale("pt-BR")).toBe("pt-BR")
    expect(normalizeLocale("fr")).toBe(DEFAULT_LOCALE)
    expect(normalizeLocale(undefined)).toBe(DEFAULT_LOCALE)
  })

  it("reads the locale from an Inertia page", () => {
    expect(localeFromPage({ props: { locale: "pt-BR" } })).toBe("pt-BR")
    expect(localeFromPage()).toBe(DEFAULT_LOCALE)
  })

  it("builds the locale switch path", () => {
    expect(localeSwitchPath("pt-BR")).toContain("locale=pt-BR")
  })

  it("creates a vue-i18n instance", () => {
    const i18n = createI18nInstance("pt-BR")

    expect(i18n.global.locale.value).toBe("pt-BR")
  })
})
