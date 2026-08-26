import type { SupportedLocale } from "@/i18n"

export type LocaleFlagPath = {
  d: string
  fill: string
}

export type LocaleIconData = {
  title: string
  paths: LocaleFlagPath[]
}

export const LOCALE_ICON_REGISTRY: Record<SupportedLocale, LocaleIconData> = {
  en: {
    title: "English",
    paths: [
      { d: "M0 0h24v24H0z", fill: "#B22234" },
      {
        d: "M0 2h24v2H0zm0 4h24v2H0zm0 4h24v2H0zm0 4h24v2H0zm0 4h24v2H0z",
        fill: "#FFFFFF",
      },
      { d: "M0 0h11v11H0z", fill: "#3C3B6E" },
    ],
  },
  "pt-BR": {
    title: "Português",
    paths: [
      { d: "M0 0h24v24H0z", fill: "#009739" },
      { d: "M12 1.5L22.5 12 12 22.5 1.5 12 12 1.5z", fill: "#FFDF00" },
      { d: "M12 8a4 4 0 1 0 0 8 4 4 0 0 0 0-8z", fill: "#002776" },
    ],
  },
}
