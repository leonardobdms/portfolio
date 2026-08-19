<script setup lang="ts">
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import HomeSection from "@/components/home/HomeSection.vue"
import Reveal from "@/components/home/Reveal.vue"
import { Badge } from "@/components/ui/badge"
import { isSpecialtySkill, skillsByCategory } from "@/lib/home"
import { cn } from "@/lib/utils"
import type { Skill } from "@/types"

const props = defineProps<{
  skills: Skill[]
}>()

const { t } = useI18n()
const groups = computed(() => skillsByCategory(props.skills))
</script>

<template>
  <HomeSection id="skills" :title="t('home.skillsTitle')">
    <div class="flex flex-col gap-10">
      <Reveal
        v-for="group in groups"
        :key="group.category"
        class="flex flex-col gap-4"
      >
        <h3 class="text-text text-lg font-medium">{{ group.category }}</h3>
        <ul class="flex flex-wrap gap-2">
          <li v-for="skill in group.items" :key="skill.id">
            <Badge
              :variant="isSpecialtySkill(skill) ? 'default' : 'outline'"
              :class="
                cn(
                  'rounded-xl px-3 py-1.5 text-sm font-medium transition-colors',
                  isSpecialtySkill(skill)
                    ? 'bg-primary text-text'
                    : 'border-border text-text-muted hover:text-text hover:bg-surface-light',
                )
              "
            >
              {{ skill.name }}
            </Badge>
          </li>
        </ul>
      </Reveal>
    </div>
  </HomeSection>
</template>
