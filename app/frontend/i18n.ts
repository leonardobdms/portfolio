import { createI18n } from 'vue-i18n'
import en from './locales/en.json'
import ptBR from './locales/pt-BR.json'

export const FALLBACK_LOCALE = 'pt-BR'

export const i18n = createI18n({
  legacy: false,
  locale: FALLBACK_LOCALE,
  fallbackLocale: FALLBACK_LOCALE,
  messages: {
    'pt-BR': ptBR,
    en,
  },
})

export function setLocale(locale: string) {
  const available = i18n.global.availableLocales as string[]
  const nextLocale = available.includes(locale) ? locale : FALLBACK_LOCALE
  i18n.global.locale.value = nextLocale as typeof i18n.global.locale.value
  return nextLocale
}
