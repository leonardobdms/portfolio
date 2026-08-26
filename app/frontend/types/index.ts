export type FlashData = {
  notice?: string
  alert?: string
}

export interface SharedProps {
  locale: string
  theme: string
  turnstile_site_key?: string | null
}

export type * from "./serializers"
