import { switchTheme } from "@/routes"

export const DEFAULT_THEME = "dark"
export const SUPPORTED_THEMES = ["dark", "light"] as const

export type SupportedTheme = (typeof SUPPORTED_THEMES)[number]

export function isSupportedTheme(theme: string): theme is SupportedTheme {
  return SUPPORTED_THEMES.includes(theme as SupportedTheme)
}

export function normalizeTheme(theme: unknown): SupportedTheme {
  return typeof theme === "string" && isSupportedTheme(theme)
    ? theme
    : DEFAULT_THEME
}

export function themeSwitchPath(theme: SupportedTheme): string {
  return switchTheme({ query: { theme } }).url
}
