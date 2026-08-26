<script setup lang="ts">
import type { HTMLAttributes } from "vue"

import { cn } from "@/lib/utils"

const props = defineProps<{
  class?: HTMLAttributes["class"]
  for?: string
}>()
</script>

<template>
  <label
    data-slot="label"
    :for="props.for"
    :class="
      cn('text-text text-sm font-medium leading-none', props.class)
    "
  >
    <slot />
  </label>
</template>
