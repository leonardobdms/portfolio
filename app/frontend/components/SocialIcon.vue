<script setup lang="ts">
import { computed } from "vue"

import { resolveSocialIcon } from "@/lib/social-icons"
import { cn } from "@/lib/utils"

const props = withDefaults(
  defineProps<{
    icon: string
    class?: string
  }>(),
  {
    class: undefined,
  },
)

const iconData = computed(() => resolveSocialIcon(props.icon))
</script>

<template>
  <svg
    v-if="iconData.type === 'brand'"
    viewBox="0 0 24 24"
    fill="currentColor"
    aria-hidden="true"
    :class="
      cn(
        'text-text-muted size-4 shrink-0 transition-colors group-hover:text-(--brand) group-focus-visible:text-(--brand)',
        props.class,
      )
    "
    :style="{ '--brand': `#${iconData.hex}` }"
  >
    <path :d="iconData.path" />
  </svg>
  <component
    v-else
    :is="iconData.component"
    aria-hidden="true"
    :stroke-width="1.5"
    :class="
      cn(
        'text-text-muted group-hover:text-primary group-focus-visible:text-primary size-4 shrink-0 transition-colors',
        props.class,
      )
    "
  />
</template>
