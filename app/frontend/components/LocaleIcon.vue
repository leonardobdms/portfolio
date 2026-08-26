<script setup lang="ts">
import { computed } from "vue"

import type { SupportedLocale } from "@/i18n"
import { LOCALE_ICON_REGISTRY } from "@/lib/locale-icons"
import { cn } from "@/lib/utils"

const props = withDefaults(
  defineProps<{
    locale: SupportedLocale
    class?: string
  }>(),
  {
    class: undefined,
  },
)

const iconData = computed(() => LOCALE_ICON_REGISTRY[props.locale])
</script>

<template>
  <svg
    viewBox="0 0 24 24"
    aria-hidden="true"
    :class="cn('size-4 shrink-0 overflow-hidden rounded-sm', props.class)"
  >
    <path
      v-for="(path, index) in iconData.paths"
      :key="index"
      :d="path.d"
      :fill="path.fill"
    />
  </svg>
</template>
