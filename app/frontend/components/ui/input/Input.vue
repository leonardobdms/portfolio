<script setup lang="ts">
import type { HTMLAttributes } from "vue"

import { cn } from "@/lib/utils"

const model = defineModel<string>()

const props = defineProps<{
  class?: HTMLAttributes["class"]
  id?: string
  type?: string
  name?: string
  placeholder?: string
  required?: boolean
  disabled?: boolean
  autocomplete?: string
  "aria-invalid"?: boolean | "true" | "false"
  "aria-describedby"?: string
}>()
</script>

<template>
  <input
    data-slot="input"
    :id="props.id"
    :type="props.type ?? 'text'"
    :name="props.name"
    :value="model"
    :placeholder="props.placeholder"
    :required="props.required"
    :disabled="props.disabled"
    :autocomplete="props.autocomplete"
    :aria-invalid="props['aria-invalid']"
    :aria-describedby="props['aria-describedby']"
    :class="
      cn(
        'border-border bg-surface text-text placeholder:text-text-muted focus-visible:ring-primary flex h-10 w-full rounded-xl border px-3 py-2 text-sm transition-colors focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-offset-background focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50',
        props.class,
      )
    "
    @input="model = ($event.target as HTMLInputElement).value"
  />
</template>
