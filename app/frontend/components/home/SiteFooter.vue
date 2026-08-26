<script setup lang="ts">
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import SocialLinks from "@/components/home/SocialLinks.vue"
import { profileSocials } from "@/lib/home"
import type { Profile } from "@/types"

const props = defineProps<{
  profile: Profile
}>()

const { t } = useI18n()
const socials = computed(() => profileSocials(props.profile))
const year = new Date().getFullYear()
</script>

<template>
  <footer
    class="border-border/80 border-t px-4 py-10 md:px-8"
    aria-label="Footer"
  >
    <div
      class="mx-auto flex max-w-7xl flex-col gap-6 md:flex-row md:items-center md:justify-between"
    >
      <p class="text-text-muted text-sm">
        {{ t("home.footer.copyright", { year, name: profile.name }) }}
      </p>
      <div class="flex flex-wrap items-center gap-4">
        <SocialLinks :links="socials" />
        <a
          href="https://github.com/leonardobdms/portfolio"
          target="_blank"
          rel="noopener noreferrer"
          class="nav-link text-text-muted hover:text-text text-sm"
        >
          {{ t("home.footer.source") }}
        </a>
      </div>
    </div>
  </footer>
</template>
