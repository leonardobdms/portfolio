<script setup lang="ts">
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import HomeSection from "@/components/home/HomeSection.vue"
import Reveal from "@/components/home/Reveal.vue"
import { Badge } from "@/components/ui/badge"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { formatEducationRange, formatMonthYear } from "@/lib/home"
import type { Education } from "@/types"

const props = defineProps<{
  educations: Education[]
}>()

const { t, locale } = useI18n()

const items = computed(() =>
  props.educations.map((education) => ({
    education,
    range: formatEducationRange(education, locale.value, t("home.present")),
    expectedCompletion:
      education.current && education.end_date
        ? t("home.expectedCompletion", {
            date: formatMonthYear(education.end_date, locale.value),
          })
        : null,
  })),
)
</script>

<template>
  <HomeSection id="education" :title="t('home.educationTitle')">
    <div :class="items.length > 1 ? 'grid gap-4 md:grid-cols-2' : 'max-w-xl'">
      <Reveal v-for="item in items" :key="item.education.id">
        <Card class="border-border bg-surface h-full shadow-none">
          <CardHeader>
            <CardTitle class="text-text text-xl tracking-tight">
              {{ item.education.course }}
            </CardTitle>
            <CardDescription class="text-text-muted text-base">
              {{ item.education.institution }}
            </CardDescription>
          </CardHeader>
          <CardContent class="flex flex-col gap-3">
            <div class="flex flex-wrap items-center gap-2">
              <p class="text-text-muted text-sm">{{ item.range }}</p>
              <Badge
                v-if="item.education.degree"
                variant="outline"
                class="border-border text-text-muted rounded-xl"
              >
                {{ item.education.degree }}
              </Badge>
            </div>
            <p v-if="item.expectedCompletion" class="text-text-muted text-sm">
              {{ item.expectedCompletion }}
            </p>
          </CardContent>
        </Card>
      </Reveal>
    </div>
  </HomeSection>
</template>
