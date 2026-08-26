<script setup lang="ts">
import { MapPin } from "lucide-vue-next"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import HomeSection from "@/components/home/HomeSection.vue"
import Reveal from "@/components/home/Reveal.vue"
import { Badge } from "@/components/ui/badge"
import {
  earliestExperienceYear,
  specialtySkills,
  splitParagraphs,
} from "@/lib/home"
import type { Profile } from "@/types"

const props = defineProps<{
  profile: Profile
}>()

const { t, locale } = useI18n()

const paragraphs = computed(() =>
  props.profile.bio ? splitParagraphs(props.profile.bio) : [],
)
const specialties = computed(() => specialtySkills(props.profile.skills))
const sinceYear = computed(() =>
  earliestExperienceYear(props.profile.experiences, locale.value),
)
</script>

<template>
  <HomeSection id="about" :title="t('home.aboutTitle')">
    <Reveal class="flex max-w-3xl flex-col gap-8">
      <div
        class="text-text-muted flex flex-col gap-4 text-base leading-relaxed"
      >
        <p v-for="(paragraph, index) in paragraphs" :key="index">
          {{ paragraph }}
        </p>
      </div>

      <ul class="flex flex-wrap gap-2">
        <li v-if="profile.location">
          <Badge
            variant="outline"
            class="border-border text-text-muted rounded-xl px-3 py-1.5"
          >
            <MapPin :stroke-width="1.5" aria-hidden="true" />
            {{ profile.location }}
          </Badge>
        </li>
        <li v-if="sinceYear">
          <Badge
            variant="outline"
            class="border-border text-text-muted rounded-xl px-3 py-1.5"
          >
            {{ t("home.since", { year: sinceYear }) }}
          </Badge>
        </li>
        <li v-for="skill in specialties" :key="skill.id">
          <Badge
            variant="outline"
            class="border-border text-text rounded-xl px-3 py-1.5"
          >
            {{ skill.name }}
          </Badge>
        </li>
      </ul>
    </Reveal>
  </HomeSection>
</template>
