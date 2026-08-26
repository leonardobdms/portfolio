<script setup lang="ts">
import type { HTMLAttributes } from "vue"

import { cn } from "@/lib/utils"

const model = defineModel<string>()

const props = defineProps<{
  class?: HTMLAttributes["class"]
  id?: string
  name?: string
  rows?: number
  placeholder?: string
  required?: boolean
  disabled?: boolean
  "aria-invalid"?: boolean | "true" | "false"
  "aria-describedby"?: string
}>()
</script>

<template>
  <textarea
    data-slot="textarea"
    :id="props.id"
    :name="props.name"
    :rows="props.rows ?? 5"
    :value="model"
    :placeholder="props.placeholder"
    :required="props.required"
    :disabled="props.disabled"
    :aria-invalid="props['aria-invalid']"
    :aria-describedby="props['aria-describedby']"
    :class="
      cn(
        'border-border bg-surface text-text placeholder:text-text-muted focus-visible:ring-primary flex min-h-[120px] w-full rounded-xl border px-3 py-2 text-sm transition-colors focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-offset-background focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50',
        props.class,
      )
    "
    @input="model = ($event.target as HTMLTextAreaElement).value"
  />
</template>
