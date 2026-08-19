import { createI18n } from "vue-i18n"

import en from "@/locales/en.json"
import ptBR from "@/locales/pt-BR.json"
import { switchLocale } from "@/routes"

export const DEFAULT_LOCALE = "en"
export const SUPPORTED_LOCALES = ["en", "pt-BR"] as const

export type SupportedLocale = (typeof SUPPORTED_LOCALES)[number]

type PageLike = {
  props?: {
    locale?: unknown
  }
}

export function isSupportedLocale(locale: string): locale is SupportedLocale {
  return SUPPORTED_LOCALES.includes(locale as SupportedLocale)
}

export function normalizeLocale(locale: unknown): SupportedLocale {
  return typeof locale === "string" && isSupportedLocale(locale)
    ? locale
    : DEFAULT_LOCALE
}

export function localeFromPage(page?: PageLike): SupportedLocale {
  return normalizeLocale(page?.props?.locale)
}

export function localeSwitchPath(locale: SupportedLocale): string {
  return switchLocale({ query: { locale } }).url
}

export function createI18nInstance(locale: unknown) {
  return createI18n({
    legacy: false,
    globalInjection: true,
    locale: normalizeLocale(locale),
    fallbackLocale: DEFAULT_LOCALE,
    messages: {
      en,
      "pt-BR": ptBR,
    },
  })
}
