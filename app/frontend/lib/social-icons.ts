import { Globe, Linkedin } from "lucide-vue-next"
import { siGithub, siGitlab, siInstagram, siWhatsapp, siX } from "simple-icons"
import type { Component } from "vue"

export type SocialIconData =
  | {
      type: "brand"
      path: string
      hex: string
      title: string
    }
  | {
      type: "lucide"
      component: Component
    }

function brand(icon: {
  path: string
  hex: string
  title: string
}): SocialIconData {
  return {
    type: "brand",
    path: icon.path,
    hex: icon.hex,
    title: icon.title,
  }
}

export const SOCIAL_ICON_REGISTRY: Record<string, SocialIconData> = {
  github: brand(siGithub),
  linkedin: { type: "lucide", component: Linkedin },
  gitlab: brand(siGitlab),
  instagram: brand(siInstagram),
  whatsapp: brand(siWhatsapp),
  x: brand(siX),
  twitter: brand(siX),
  website: { type: "lucide", component: Globe },
}

export function resolveSocialIcon(key: string): SocialIconData {
  const normalized = key.toLowerCase()

  if (normalized.includes("github")) return SOCIAL_ICON_REGISTRY.github
  if (normalized.includes("linkedin")) return SOCIAL_ICON_REGISTRY.linkedin
  if (normalized.includes("gitlab")) return SOCIAL_ICON_REGISTRY.gitlab
  if (normalized.includes("instagram")) return SOCIAL_ICON_REGISTRY.instagram
  if (normalized.includes("whatsapp")) return SOCIAL_ICON_REGISTRY.whatsapp
  if (normalized.includes("twitter") || normalized === "x")
    return SOCIAL_ICON_REGISTRY.x

  return SOCIAL_ICON_REGISTRY.website
}
