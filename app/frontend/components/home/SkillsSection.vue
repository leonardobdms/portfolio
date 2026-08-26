<script setup lang="ts">
import {
  Container,
  FlaskConical,
  Layout,
  Plug,
  Server,
  Shapes,
} from "lucide-vue-next"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import SkillIcon from "@/components/SkillIcon.vue"
import HomeSection from "@/components/home/HomeSection.vue"
import Reveal from "@/components/home/Reveal.vue"
import { Badge } from "@/components/ui/badge"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip"
import { isSpecialtySkill, skillsByCategory } from "@/lib/home"
import { CATEGORY_FALLBACK_ICONS } from "@/lib/skill-icons"
import { cn } from "@/lib/utils"
import type { Skill } from "@/types"

const props = defineProps<{
  skills: Skill[]
}>()

const { t } = useI18n()
const groups = computed(() => skillsByCategory(props.skills))

const categoryIcons: Record<string, typeof Server> = {
  Backend: Server,
  Frontend: Layout,
  "Testes e documentação": FlaskConical,
  Integrações: Plug,
  WordPress: Container,
  DevOps: Container,
  Arquitetura: Shapes,
  ...CATEGORY_FALLBACK_ICONS,
}

function tooltipText(skill: Skill): string | null {
  const parts = [skill.level, skill.description].filter(Boolean)
  return parts.length > 0 ? parts.join(" — ") : null
}
</script>

<template>
  <HomeSection id="skills" :title="t('home.skillsTitle')">
    <TooltipProvider>
      <div class="flex flex-col gap-10">
        <Reveal
          v-for="group in groups"
          :key="group.category"
          class="flex flex-col gap-4"
        >
          <div class="flex items-center gap-2">
            <component
              :is="categoryIcons[group.category] ?? Shapes"
              class="text-text-muted size-5 shrink-0"
              aria-hidden="true"
              :stroke-width="1.5"
            />
            <h3 class="text-text text-lg font-medium">{{ group.category }}</h3>
          </div>
          <ul class="flex flex-wrap gap-2">
            <li v-for="skill in group.items" :key="skill.id">
              <Tooltip v-if="tooltipText(skill)">
                <TooltipTrigger as-child>
                  <Badge
                    :variant="isSpecialtySkill(skill) ? 'default' : 'outline'"
                    :class="
                      cn(
                        'group inline-flex items-center gap-2 rounded-xl px-3 py-1.5 text-sm font-medium transition-colors',
                        isSpecialtySkill(skill)
                          ? 'bg-primary-dark text-text'
                          : 'border-border text-text-muted hover:text-text hover:bg-surface-light',
                      )
                    "
                  >
                    <SkillIcon :icon="skill.icon" :category="skill.category" />
                    {{ skill.name }}
                  </Badge>
                </TooltipTrigger>
                <TooltipContent>
                  <p>{{ tooltipText(skill) }}</p>
                </TooltipContent>
              </Tooltip>
              <Badge
                v-else
                :variant="isSpecialtySkill(skill) ? 'default' : 'outline'"
                :class="
                  cn(
                    'group inline-flex items-center gap-2 rounded-xl px-3 py-1.5 text-sm font-medium transition-colors',
                    isSpecialtySkill(skill)
                      ? 'bg-primary-dark text-text'
                      : 'border-border text-text-muted hover:text-text hover:bg-surface-light',
                  )
                "
              >
                <SkillIcon :icon="skill.icon" :category="skill.category" />
                {{ skill.name }}
              </Badge>
            </li>
          </ul>
        </Reveal>
      </div>
    </TooltipProvider>
  </HomeSection>
</template>
