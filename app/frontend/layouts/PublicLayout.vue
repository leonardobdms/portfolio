<script setup lang="ts">
import { useI18n } from "vue-i18n"

import BackToTop from "@/components/home/BackToTop.vue"
import SiteFooter from "@/components/home/SiteFooter.vue"
import SiteHeader from "@/components/home/SiteHeader.vue"
import type { Profile } from "@/types"

const props = withDefaults(
  defineProps<{
    profile: Profile
    basePath?: string
    activeSection?: string | null
  }>(),
  {
    basePath: "",
    activeSection: null,
  },
)
const { t } = useI18n()
</script>

<template>
  <div
    id="top"
    class="bg-background text-text min-h-[100dvh] font-sans antialiased"
  >
    <a
      href="#main"
      class="focus:bg-primary focus:text-text sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:z-50 focus:rounded-xl focus:px-4 focus:py-2 focus:outline-none"
    >
      {{ t("home.skipToContent") }}
    </a>

    <SiteHeader
      :profile="props.profile"
      :base-path="props.basePath"
      :active-section="props.activeSection"
    />

    <main id="main" tabindex="-1">
      <slot />
    </main>

    <SiteFooter :profile="props.profile" />
    <BackToTop />
  </div>
</template>
