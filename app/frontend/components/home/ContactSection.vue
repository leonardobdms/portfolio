<script setup lang="ts">
import { Mail, Phone } from "lucide-vue-next"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import SocialLinks from "@/components/home/SocialLinks.vue"
import { Button } from "@/components/ui/button"
import { profileSocials, telHref } from "@/lib/home"
import type { Profile } from "@/types"

const props = defineProps<{
  profile: Profile
}>()

const { t } = useI18n()
const socials = computed(() => profileSocials(props.profile))
</script>

<template>
  <section
    id="contact"
    class="mx-auto max-w-7xl scroll-mt-24 px-4 py-16 md:px-8 md:py-24"
  >
    <div
      class="border-border bg-surface flex flex-col gap-8 rounded-xl border px-6 py-12 md:px-12 md:py-16"
    >
      <h2 class="text-text text-3xl font-semibold tracking-tight md:text-5xl">
        {{ t("home.contactTitle") }}
      </h2>
      <p
        class="text-text-muted max-w-[40ch] text-base leading-relaxed md:text-lg"
      >
        {{
          profile.available_for_work
            ? t("home.contactBodyAvailable")
            : t("home.contactBody")
        }}
      </p>
      <div class="flex flex-wrap items-center gap-3">
        <Button
          v-if="profile.email"
          as="a"
          size="lg"
          :href="`mailto:${profile.email}`"
        >
          <Mail :stroke-width="1.5" aria-hidden="true" />
          {{ profile.email }}
        </Button>
        <Button
          v-if="profile.phone"
          as="a"
          variant="outline"
          size="lg"
          :href="telHref(profile.phone)"
        >
          <Phone :stroke-width="1.5" aria-hidden="true" />
          {{ profile.phone }}
        </Button>
        <SocialLinks :links="socials" />
      </div>
    </div>
  </section>
</template>
