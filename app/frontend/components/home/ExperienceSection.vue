<script setup lang="ts">
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import HomeSection from "@/components/home/HomeSection.vue"
import Reveal from "@/components/home/Reveal.vue"
import { Badge } from "@/components/ui/badge"
import { formatDateRange, splitParagraphs } from "@/lib/home"
import type { Experience } from "@/types"

const props = defineProps<{
  experiences: Experience[]
}>()

const { t, locale } = useI18n()

const items = computed(() =>
  props.experiences.map((experience) => ({
    experience,
    range: formatDateRange(
      experience.start_date,
      experience.end_date,
      experience.current,
      locale.value,
      t("home.present"),
    ),
    paragraphs: experience.description
      ? splitParagraphs(experience.description)
      : [],
  })),
)
</script>

<template>
  <HomeSection id="experience" :title="t('home.experienceTitle')">
    <ol class="flex flex-col gap-10">
      <li v-for="item in items" :key="item.experience.id">
        <Reveal class="flex gap-4 md:gap-6">
          <span
            class="bg-primary mt-2.5 size-2 shrink-0 rounded-full"
            aria-hidden="true"
          />
          <div class="flex min-w-0 flex-col gap-3">
            <div class="flex flex-wrap items-center gap-2">
              <h3
                class="text-text text-xl font-semibold tracking-tight md:text-2xl"
              >
                {{ item.experience.company }}
              </h3>
              <Badge
                v-if="item.experience.employment_type"
                variant="outline"
                class="border-border text-text-muted rounded-xl"
              >
                {{ item.experience.employment_type }}
              </Badge>
            </div>
            <p class="text-text text-base font-medium">
              {{ item.experience.role }}
            </p>
            <p class="text-text-muted text-sm">
              <time :datetime="item.experience.start_date">{{
                item.range
              }}</time>
              <span v-if="item.experience.location">
                · {{ item.experience.location }}
              </span>
            </p>
            <div
              v-if="item.paragraphs.length > 0"
              class="text-text-muted flex max-w-[65ch] flex-col gap-3 text-base leading-relaxed"
            >
              <p v-for="(paragraph, index) in item.paragraphs" :key="index">
                {{ paragraph }}
              </p>
            </div>
          </div>
        </Reveal>
      </li>
    </ol>
  </HomeSection>
</template>
